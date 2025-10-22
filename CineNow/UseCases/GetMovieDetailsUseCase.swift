//
//  GetMovieDetailsUseCase .swift
//  CineNow
//
//  Created by Mickael Belhassen on 22/10/2025.
//

import ComposableArchitecture
import Foundation

protocol GetMovieDetailsUseCaseService {
    func getDetails(id: Int) async throws -> Movie
}

struct GetMovieDetailsUseCase: GetMovieDetailsUseCaseService {
    @Dependency(\.movieRepository) var movieRepository: MovieRepositoryService
}

// MARK: -

extension GetMovieDetailsUseCase {
    
    func getDetails(id: Int) async throws -> Movie {
        try await movieRepository.fetchDetails(id: id)
    }
}
