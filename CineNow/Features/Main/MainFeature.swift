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
        
        @Presents var movieDetailsState: MovieDetailsFeature.State?
    }

    enum Action {
        case moviesListAction(MoviesListFeature.Action)
        case movieDetailsAction(PresentationAction<MovieDetailsFeature.Action>)
    }

    var body: some Reducer<State, Action> {
        Scope(state: \.moviesListState, action: \.moviesListAction) {
            MoviesListFeature()
        }

        Reduce { state, action in
            switch action {
                case let .moviesListAction(.movieDidTap(movie)):
                    state.movieDetailsState = MovieDetailsFeature.State(movieID: movie.id)
                case .moviesListAction, .movieDetailsAction:
                    break
            }
            
            return .none
        }
        .ifLet(\.$movieDetailsState, action: \.movieDetailsAction) {
            MovieDetailsFeature()
        }
    }
}
