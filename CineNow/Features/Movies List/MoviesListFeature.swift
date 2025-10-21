//
//  MoviesListFeature.swift
//  CineNow
//
//  Created by Mickael Belhassen on 21/10/2025.
//

import ComposableArchitecture
import Foundation

@Reducer
struct MoviesListFeature {
    @ObservableState
    struct State {
        var movies: [Movie] = []
        var isLoading = false
    }

    enum Action {
        case onAppear
        case loadMovies
        case moviesLoaded([Movie])
        case displayErrorMessage(String)
        case movieDidTap(Movie)
    }

    // MARK: - Dependencies

    @Dependency(\.getMoviesUseCase) var getMoviesUseCase

    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
                case .onAppear:
                    return .send(.loadMovies)

                case .loadMovies:
                    state.isLoading = true

                    return .run { send in
                        do {
                            let movies = try await getMoviesUseCase.getFeatured()
                            await send(.moviesLoaded(movies))
                        } catch {
                            await send(.displayErrorMessage(error.localizedDescription))
                        }
                    }
                case let .moviesLoaded(movies):
                    state.movies = movies
                    state.isLoading = false

                case let .displayErrorMessage(message):
                    state.isLoading = false
                    // TODO: Handle error display
                case let .movieDidTap(movie):
                    // TODO: Handle movie selection
                    break
            }

            return .none
        }
    }
}
