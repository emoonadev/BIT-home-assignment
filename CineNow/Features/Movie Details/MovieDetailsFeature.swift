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
        
        init(movieID: Int, isFavorite: Bool) {
            self.movieID = movieID
            self.isFavorite = isFavorite
        }
    }

    enum Action {
        case onAppear
        case loadMovieDetails(Bool)
        case refreshData
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
                    .send(.loadMovieDetails(false)),
                    .send(.checkFavoriteStatus)
                )
            case .refreshData:
                    return .send(.loadMovieDetails(true))
            case let .loadMovieDetails(isLoadingStateIgnored):
                if !isLoadingStateIgnored {
                    state.isLoading = true
                }
                
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
                        await send(.favoriteToggled)
                        
                        if isFavorite {
                            try await toggleFavoriteUseCase.removeFromFavorites(movieID: movieID)
                        } else {
                            try await toggleFavoriteUseCase.addToFavorites(movieID: movieID)
                        }
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
