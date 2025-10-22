//
//  ModelDependencyValues.swift
//  CineNow
//
//  Created by Mickael Belhassen on 21/10/2025.
//

import Foundation
import ComposableArchitecture

// MARK: - Keys

extension DependencyValues {
        
    var getMoviesUseCase: GetMoviesUseCaseService {
        get { self[GetMoviesUseCaseKey.self] }
        set { self[GetMoviesUseCaseKey.self] = newValue }
    }
    
    var getMovieDetailsUseCase: GetMovieDetailsUseCaseService {
        get { self[GetMovieDetailsUseCaseKey.self] }
        set { self[GetMovieDetailsUseCaseKey.self] = newValue }
    }

    var getFavoritesUseCase: GetFavoritesUseCaseService {
        get { self[GetFavoritesUseCaseKey.self] }
        set { self[GetFavoritesUseCaseKey.self] = newValue }
    }

    var toggleFavoriteUseCase: ToggleFavoriteUseCaseService {
        get { self[ToggleFavoriteUseCaseKey.self] }
        set { self[ToggleFavoriteUseCaseKey.self] = newValue }
    }
        
    var movieRepository: MovieRepositoryService {
        get { self[MovieRepositoryKey.self] }
        set { self[MovieRepositoryKey.self] = newValue }
    }
        
    var movieRemoteDataSource: MovieRemoteDataSourceService {
        get { self[MovieRemoteDataSourceKey.self] }
        set { self[MovieRemoteDataSourceKey.self] = newValue }
    }
    
}

// MARK: -

extension DependencyValues {
    
    // MARK: - UseCases

    enum GetMoviesUseCaseKey: DependencyKey {
        static let liveValue: GetMoviesUseCaseService = GetMoviesUseCase()
        static let testValue: GetMoviesUseCaseService = GetMoviesUseCase()
        static let previewValue: GetMoviesUseCaseService = GetMoviesUseCase()
    }

    enum GetMovieDetailsUseCaseKey: DependencyKey {
        static let liveValue: GetMovieDetailsUseCaseService = GetMovieDetailsUseCase()
        static let testValue: GetMovieDetailsUseCaseService = GetMovieDetailsUseCase()
        static let previewValue: GetMovieDetailsUseCaseService = GetMovieDetailsUseCase()
    }

    enum GetFavoritesUseCaseKey: DependencyKey {
        static let liveValue: GetFavoritesUseCaseService = GetFavoritesUseCase()
        static let testValue: GetFavoritesUseCaseService = GetFavoritesUseCase()
        static let previewValue: GetFavoritesUseCaseService = GetFavoritesUseCase()
    }

    enum ToggleFavoriteUseCaseKey: DependencyKey {
        static let liveValue: ToggleFavoriteUseCaseService = ToggleFavoriteUseCase()
        static let testValue: ToggleFavoriteUseCaseService = ToggleFavoriteUseCase()
        static let previewValue: ToggleFavoriteUseCaseService = ToggleFavoriteUseCase()
    }

    // MARK: - Repositories

    fileprivate enum MovieRepositoryKey: DependencyKey {
        static let liveValue: MovieRepositoryService = MovieRepository()
        static let testValue: MovieRepositoryService = MovieRepository()
        static let previewValue: MovieRepositoryService = MovieRepository()
    }

    // MARK: - RemoteDataSources

    fileprivate enum MovieRemoteDataSourceKey: DependencyKey {
        static let liveValue: MovieRemoteDataSourceService = MovieRemoteDataSource()
        static let testValue: MovieRemoteDataSourceService = MockMovieRemoteDataSource()
        static let previewValue: MovieRemoteDataSourceService = MockMovieRemoteDataSource()
    }
    
}