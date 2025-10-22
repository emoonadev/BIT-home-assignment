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
    }

    enum Action {
        case moviesListAction(MoviesListFeature.Action)
    }

    var body: some Reducer<State, Action> {
        Scope(state: \.moviesListState, action: \.moviesListAction) {
            MoviesListFeature()
        }

        Reduce { state, action in
            return .none
        }
    }
}
