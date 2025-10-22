//
//  GetMoviesUseCase.swift
//  CineNow
//
//  Created by Mickael Belhassen on 21/10/2025.
//

import ComposableArchitecture
import Foundation

protocol GetMoviesUseCaseService {
    func getList(for category: Movie.Category) async throws -> [Movie]
}

struct GetMoviesUseCase: GetMoviesUseCaseService {
    @Dependency(\.movieRepository) var movieRepository: MovieRepositoryService
}

// MARK: -

extension GetMoviesUseCase {
    
    func getList(for category: Movie.Category) async throws -> [Movie] {
        switch category {
            case .upcoming: try await movieRepository.fetchUpcoming(at: 1)
            case .topRated: try await movieRepository.fetchTopRated(at: 1)
            case .nowPlaying: try await movieRepository.fetchNowPlaying(at: 1)
        }
    }
}
