//
//  ToggleFavoriteUseCaseService.swift
//  CineNow
//
//  Created by Mickael Belhassen on 22/10/2025.
//

import ComposableArchitecture
import Foundation

protocol ToggleFavoriteUseCaseService {
    func addToFavorites(movieID: Int) async throws
    func removeFromFavorites(movieID: Int) async throws
}

struct ToggleFavoriteUseCase: ToggleFavoriteUseCaseService {
    @Dependency(\.movieRepository) var movieRepository: MovieRepositoryService
}

// MARK: -

extension ToggleFavoriteUseCase {
    
    func addToFavorites(movieID: Int) async throws {
        try await movieRepository.addToFavorites(id: movieID)
    }
    
    func removeFromFavorites(movieID: Int) async throws {
        try await movieRepository.removeFromFavorites(id: movieID)
    }
    
}
