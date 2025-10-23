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
        var categoryStates: [Movie.Category: CategoryState] = [:]
        var selectedCategory: Movie.Category = .upcoming
        var isLoading = false
        var isLoadingMore = false
        
        var currentCategoryState: CategoryState {
            get { categoryStates[selectedCategory] ?? CategoryState() }
            set { categoryStates[selectedCategory] = newValue }
        }
        
        var movies: [Movie] { currentCategoryState.movies }
        var currentPage: Int { currentCategoryState.currentPage }
        var totalPages: Int { currentCategoryState.totalPages }
        var hasMorePages: Bool { currentCategoryState.hasMorePages }
        
        @Presents var movieDetailsState: MovieDetailsFeature.State?
    }
    
    struct CategoryState {
        var movies: [Movie] = []
        var currentPage = 0
        var totalPages = 0
        var currentMovieID = 0
        var hasMorePages: Bool { currentPage < totalPages }
    }

    enum Action {
        case onAppear
        case categoryDidChange(Movie.Category)
        case loadMovies(_ isLoadingStateIgnored: Bool = false)
        case refreshMovies
        case loadMoreMovies
        case moviesLoaded(MoviesListResponseDTO)
        case moreMoviesLoaded(MoviesListResponseDTO)
        case displayErrorMessage(String)
        case movieDidTap(Movie)
        case movieAppearedNearEnd(Movie)
        case movieDetailsAction(PresentationAction<MovieDetailsFeature.Action>)
    }

    // MARK: - Dependencies

    @Dependency(\.getMoviesUseCase) var getMoviesUseCase

    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
                case .refreshMovies:
                    return .send(.loadMovies(true))
                case .onAppear:
                    guard state.currentCategoryState.movies.isEmpty else { return .none }
                    return .send(.loadMovies())
                case let .categoryDidChange(category):
                    state.selectedCategory = category
                    guard state.currentCategoryState.movies.isEmpty else { return .none }
                    return .send(.loadMovies())
                case .loadMovies:
                    state.isLoading = true
                    state.currentCategoryState.currentPage = 1
                    
                    return .run { [category = state.selectedCategory] send in
                        do {
                            let response = try await getMoviesUseCase.getList(for: category, page: 1)
                            await send(.moviesLoaded(response))
                        } catch {
                            await send(.displayErrorMessage(error.localizedDescription))
                        }
                    }
                    
                case .loadMoreMovies:
                    guard state.hasMorePages, !state.isLoadingMore else { return .none }
                    state.isLoadingMore = true
                
                    let nextPage = state.currentPage + 1
                    
                    return .run { [category = state.selectedCategory] send in
                        do {
                            let response = try await getMoviesUseCase.getList(for: category, page: nextPage)
                            await send(.moreMoviesLoaded(response))
                        } catch {
                            await send(.displayErrorMessage(error.localizedDescription))
                        }
                    }
                case let .moviesLoaded(response):
                state.currentCategoryState.movies = response.results.sorted { $0.releaseDate > $1.releaseDate}
                    state.currentCategoryState.currentPage = response.page
                    state.currentCategoryState.totalPages = response.totalPages
                    state.isLoading = false
                case let .moreMoviesLoaded(response):
                    state.currentCategoryState.movies.append(contentsOf: response.results.sorted { $0.releaseDate > $1.releaseDate})
                    state.currentCategoryState.currentPage = response.page
                    state.currentCategoryState.totalPages = response.totalPages
                    state.isLoadingMore = false
                case .displayErrorMessage(_):
                    state.isLoading = false
                    state.isLoadingMore = false
                case let .movieAppearedNearEnd(movie):
                    guard let movieIndex = state.movies.firstIndex(where: { $0.id == movie.id }) else { return .none }
                    state.currentCategoryState.currentMovieID = movie.id
                
                    let indexFromEnd = state.movies.count - movieIndex
                    if indexFromEnd <= 5, state.hasMorePages, !state.isLoadingMore {
                        return .send(.loadMoreMovies)
                    }
                case let .movieDidTap(movie):
                    state.movieDetailsState = MovieDetailsFeature.State(movieID: movie.id, isFavorite: false)
                case .movieDetailsAction(_): break
            }
            
            return .none
        }
        .ifLet(\.$movieDetailsState, action: \.movieDetailsAction) {
            MovieDetailsFeature()
        }
    }
}
