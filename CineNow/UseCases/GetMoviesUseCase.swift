//
//  GetMoviesUseCase.swift
//  CineNow
//
//  Created by Mickael Belhassen on 21/10/2025.
//

import ComposableArchitecture
import Foundation

protocol GetMoviesUseCaseService {
    func getFeatured() async throws -> [Movie]
}

struct GetMoviesUseCase: GetMoviesUseCaseService {
    @Dependency(\.movieRepository) var movieRepository: MovieRepositoryService
}

// MARK: -

extension GetMoviesUseCase {
    
    func getFeatured() async throws -> [Movie] {
        try await movieRepository.fetchPopular(at: 1)
    }
    
}
