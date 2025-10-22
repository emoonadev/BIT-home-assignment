//
//  FavoritesFeature.swift
//  CineNow
//
//  Created by Mickael Belhassen on 22/10/2025.
//

import ComposableArchitecture
import Foundation

@Reducer
struct FavoritesFeature {
    @ObservableState
    struct State {
        var favorites: [Movie] = []
        var isLoading = false
        var errorMessage: String?
        
        @Presents var movieDetailsState: MovieDetailsFeature.State?
    }

    enum Action {
        case onAppear
        case loadFavorites
        case favoritesLoaded(MoviesListResponseDTO)
        case displayErrorMessage(String)
        case movieDidTap(Movie)
        case refreshFavorites
        case movieDetailsAction(PresentationAction<MovieDetailsFeature.Action>)
    }

    // MARK: - Dependencies

    @Dependency(\.getFavoritesUseCase) var getFavoritesUseCase

    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .send(.loadFavorites)
            case .loadFavorites, .refreshFavorites:
                state.isLoading = true
                state.errorMessage = nil

                return .run { send in
                    do {
                        let response = try await getFavoritesUseCase.getFavorites(page: 1)
                        await send(.favoritesLoaded(response))
                    } catch {
                        await send(.displayErrorMessage(error.localizedDescription))
                    }
                }
            case let .favoritesLoaded(response):
                state.favorites = response.results
                state.isLoading = false
            case let .displayErrorMessage(message):
                state.errorMessage = message
                state.isLoading = false
            case let .movieDidTap(movie):
                state.movieDetailsState = MovieDetailsFeature.State(movieID: movie.id)
            case .movieDetailsAction:
                break
            }

            return .none
        }
        .ifLet(\.$movieDetailsState, action: \.movieDetailsAction) {
            MovieDetailsFeature()
        }
    }
}
