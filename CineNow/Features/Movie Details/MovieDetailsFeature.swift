//
//  MovieDetailsFeature.swift
//  CineNow
//
//  Created by Mickael Belhassen on 22/10/2025.
//

import ComposableArchitecture
import Foundation

@Reducer
struct MovieDetailsFeature {
    @ObservableState
    struct State {
        let movieID: Int
        var movie: Movie?
        var isLoading = false
        var errorMessage: String?
        var isFavorite = false
        var isTogglingFavorite = false
    }

    enum Action {
        case onAppear
        case loadMovieDetails
        case movieDetailsLoaded(Movie)
        case displayErrorMessage(String)
        case toggleFavorite
        case favoriteToggled
        case checkFavoriteStatus
        case favoriteStatusChecked(Bool)
    }

    // MARK: - Dependencies

    @Dependency(\.getMovieDetailsUseCase) var getMovieDetailsUseCase
    @Dependency(\.toggleFavoriteUseCase) var toggleFavoriteUseCase
    @Dependency(\.getFavoritesUseCase) var getFavoritesUseCase

    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
                case .onAppear:
                    guard state.movie == nil else { return .none }
                    return .merge(
                        .send(.loadMovieDetails),
                        .send(.checkFavoriteStatus)
                    )
                    
                case .loadMovieDetails:
                    state.isLoading = true
                    state.errorMessage = nil
                    
                    return .run { [movieID = state.movieID] send in
                        do {
                            let movie = try await getMovieDetailsUseCase.getDetails(id: movieID)
                            await send(.movieDetailsLoaded(movie))
                        } catch {
                            await send(.displayErrorMessage(error.localizedDescription))
                        }
                    }
                    
                case let .movieDetailsLoaded(movie):
                    state.movie = movie
                    state.isLoading = false
                    
                case let .displayErrorMessage(message):
                    state.errorMessage = message
                    state.isLoading = false
                    
                case .checkFavoriteStatus:
                    return .run { [movieID = state.movieID] send in
                        do {
                            let response = try await getFavoritesUseCase.getFavorites(page: 1)
                            let isFavorite = response.results.contains { $0.id == movieID }
                            await send(.favoriteStatusChecked(isFavorite))
                        } catch {
                            await send(.favoriteStatusChecked(false))
                        }
                    }
                    
                case let .favoriteStatusChecked(isFavorite):
                    state.isFavorite = isFavorite
                    
                case .toggleFavorite:
                    state.isTogglingFavorite = true
                    
                    return .run { [movieID = state.movieID, isFavorite = state.isFavorite] send in
                        do {
                            if isFavorite {
                                try await toggleFavoriteUseCase.removeFromFavorites(movieID: movieID)
                            } else {
                                try await toggleFavoriteUseCase.addToFavorites(movieID: movieID)
                            }
                            await send(.favoriteToggled)
                        } catch {
                            await send(.displayErrorMessage("Failed to update favorite status"))
                        }
                    }
                    
                case .favoriteToggled:
                    state.isFavorite.toggle()
                    state.isTogglingFavorite = false
            }
            
            return .none
        }
    }
}
