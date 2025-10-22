//
//  MainFeature.swift
//  CineNow
//
//  Created by Mickael Belhassen on 22/10/2025.
//

import ComposableArchitecture
import Foundation

@Reducer
struct MainFeature {
    
    @ObservableState
    struct State {
        var moviesListState = MoviesListFeature.State()
        var favoritesState = FavoritesFeature.State()
        
        @Presents var movieDetailsState: MovieDetailsFeature.State?
    }

    enum Action {
        case moviesListAction(MoviesListFeature.Action)
        case favoritesAction(FavoritesFeature.Action)
    }

    var body: some Reducer<State, Action> {
        Scope(state: \.moviesListState, action: \.moviesListAction) {
            MoviesListFeature()
        }
        
        Scope(state: \.favoritesState, action: \.favoritesAction) {
            FavoritesFeature()
        }

        Reduce { state, action in
            switch action {
                case let .moviesListAction(.movieDidTap(movie)):
                    state.movieDetailsState = MovieDetailsFeature.State(movieID: movie.id)
                case let .favoritesAction(.movieDidTap(movie)):
                    state.movieDetailsState = MovieDetailsFeature.State(movieID: movie.id)
                case .moviesListAction, .favoritesAction:
                    break
            }
            
            return .none
        }
    }
}

// MARK: -

extension MainFeature {
    
    enum Tab: Int, CaseIterable {
        case movies, favorites
        
        var title: String {
            switch self {
                case .movies: "Movies"
                case .favorites: "Favorites"
            }
        }
    }
    
}
