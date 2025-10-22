//
//  MovieRepository.swift
//  CineNow
//
//  Created by Mickael Belhassen on 21/10/2025.
//

import Foundation
import ComposableArchitecture

protocol MovieRepositoryService {
    func fetchUpcoming(at page: Int) async throws -> [Movie]
    func fetchTopRated(at page: Int) async throws -> [Movie]
    func fetchNowPlaying(at page: Int) async throws -> [Movie]
}

struct MovieRepository: MovieRepositoryService {
    @Dependency(\.movieRemoteDataSource) var remoteDataSource
}

// MARK: - CRUD

extension MovieRepository {
    
    func fetchUpcoming(at page: Int) async throws -> [Movie] {
        try await remoteDataSource.fetchUpcoming(at: page)
    }
    
    func fetchTopRated(at page: Int) async throws -> [Movie] {
        try await remoteDataSource.fetchTopRated(at: page)
    }
    
    func fetchNowPlaying(at page: Int) async throws -> [Movie] {
        try await remoteDataSource.fetchNowPlaying(at: page)
    }
    
}
