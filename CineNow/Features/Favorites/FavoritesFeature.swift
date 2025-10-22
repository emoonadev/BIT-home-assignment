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
    }

    enum Action {
        case onAppear
        case loadFavorites
        case favoritesLoaded(MoviesListResponseDTO)
        case displayErrorMessage(String)
        case movieDidTap(Movie)
        case refreshFavorites
    }

    // MARK: - Dependencies

    @Dependency(\.getFavoritesUseCase) var getFavoritesUseCase

    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                guard state.favorites.isEmpty else { return .none }
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
            case .movieDidTap:
                // Handled by parent
                return .none
            }

            return .none
        }
    }
}
