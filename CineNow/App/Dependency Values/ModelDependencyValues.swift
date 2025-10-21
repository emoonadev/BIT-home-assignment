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

    fileprivate enum GetMoviesUseCaseKey: DependencyKey {
        static let liveValue: GetMoviesUseCaseService = GetMoviesUseCase()
    }

    // MARK: - Repositories

    fileprivate enum MovieRepositoryKey: DependencyKey {
        static let liveValue: MovieRepositoryService = MovieRepository()
    }

    // MARK: - RemoteDataSources

    fileprivate enum MovieRemoteDataSourceKey: DependencyKey {
        static let liveValue: MovieRemoteDataSourceService = MovieRemoteDataSource()
        static let testValue: MovieRemoteDataSourceService = MockMovieRemoteDataSource()
    }
    
}
