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
    }

    enum Action {
        case onAppear
        case loadMovieDetails
        case movieDetailsLoaded(Movie)
        case displayErrorMessage(String)
    }

    // MARK: - Dependencies

    @Dependency(\.getMovieDetailsUseCase) var getMovieDetailsUseCase

    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
                case .onAppear:
                    guard state.movie == nil else { return .none }
                    return .send(.loadMovieDetails)
                    
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
                    // TODO: Display error msg
            }
            
            return .none
        }
    }
}
