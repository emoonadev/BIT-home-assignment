//
//  MovieRepository.swift
//  CineNow
//
//  Created by Mickael Belhassen on 21/10/2025.
//

import Foundation
import ComposableArchitecture

protocol MovieRepositoryService {
    func fetchUpcoming(at page: Int) async throws -> MoviesListResponseDTO
    func fetchTopRated(at page: Int) async throws -> MoviesListResponseDTO
    func fetchNowPlaying(at page: Int) async throws -> MoviesListResponseDTO
    func fetchDetails(id: Int) async throws -> Movie
    func fetchFavorites(at page: Int) async throws -> MoviesListResponseDTO
    func addToFavorites(id: Int) async throws
    func removeFromFavorites(id: Int) async throws
}

struct MovieRepository: MovieRepositoryService {
    @Dependency(\.movieRemoteDataSource) var remoteDataSource
}

// MARK: - CRUD

extension MovieRepository {
    
    func fetchUpcoming(at page: Int) async throws -> MoviesListResponseDTO {
        try await remoteDataSource.fetchUpcoming(at: page)
    }
    
    func fetchTopRated(at page: Int) async throws -> MoviesListResponseDTO {
        try await remoteDataSource.fetchTopRated(at: page)
    }
    
    func fetchNowPlaying(at page: Int) async throws -> MoviesListResponseDTO {
        try await remoteDataSource.fetchNowPlaying(at: page)
    }
    
    func fetchDetails(id: Int) async throws -> Movie {
        try await remoteDataSource.fetchDetails(id: id)
    }

    func fetchFavorites(at page: Int) async throws -> MoviesListResponseDTO {
        try await remoteDataSource.fetchFavorites(at: page)
    }

    func addToFavorites(id: Int) async throws {
        try await remoteDataSource.addToFavorites(id)
    }

    func removeFromFavorites(id: Int) async throws {
        try await remoteDataSource.removeFromFavorites(id)
    }
}
