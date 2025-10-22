//
//  GetFavoritesUseCaseService.swift
//  CineNow
//
//  Created by Mickael Belhassen on 22/10/2025.
//

import ComposableArchitecture
import Foundation

protocol GetFavoritesUseCaseService {
    func getFavorites(page: Int) async throws -> MoviesListResponseDTO
}

struct GetFavoritesUseCase: GetFavoritesUseCaseService {
    @Dependency(\.movieRepository) var movieRepository: MovieRepositoryService
}

// MARK: -

extension GetFavoritesUseCase {
    
    func getFavorites(page: Int) async throws -> MoviesListResponseDTO {
        try await movieRepository.fetchFavorites(at: page)
    }
    
}
