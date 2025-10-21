//
//  MovieRepository.swift
//  CineNow
//
//  Created by Mickael Belhassen on 21/10/2025.
//

import Foundation
import ComposableArchitecture

protocol MovieRepositoryService {
    func fetchPopular(at page: Int) async throws -> [Movie]
}

struct MovieRepository: MovieRepositoryService {
    @Dependency(\.movieRemoteDataSource) var remoteDataSource
}

// MARK: - CRUD

extension MovieRepository {
    
    func fetchPopular(at page: Int) async throws -> [Movie] {
        try await remoteDataSource.fetchPopular(at: page)
    }
    
}
