//
//  GetMoviesUseCase.swift
//  CineNow
//
//  Created by Mickael Belhassen on 21/10/2025.
//

import ComposableArchitecture
import Foundation

protocol GetMoviesUseCaseService {
    func getList(for category: Movie.Category, page: Int) async throws -> MoviesListResponseDTO
}

struct GetMoviesUseCase: GetMoviesUseCaseService {
    @Dependency(\.movieRepository) var movieRepository: MovieRepositoryService
}

// MARK: -

extension GetMoviesUseCase {
    
    func getList(for category: Movie.Category, page: Int) async throws -> MoviesListResponseDTO {
        switch category {
            case .upcoming: 
                return try await movieRepository.fetchUpcoming(at: page)
            case .topRated: 
                return try await movieRepository.fetchTopRated(at: page)
            case .nowPlaying: 
                return try await movieRepository.fetchNowPlaying(at: page)
        }
    }
}