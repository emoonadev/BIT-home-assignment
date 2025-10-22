//
//  GetMoviesUseCaseTests.swift
//  CineNowTests
//
//  Created by Mickael Belhassen on 21/10/2025.
//

import Testing
import ComposableArchitecture
@testable import CineNow

@MainActor
struct GetMovieDetailsUseCaseTests {
    
    var sut: GetMovieDetailsUseCaseService
    
    init() {
        sut = withDependencies {
            $0.context = .test
        } operation: {
            GetMovieDetailsUseCase()
        }
    }
    
}

// MARK: - Success

extension GetMovieDetailsUseCaseTests {
    
    @Test("Get movie details returns expected movie for valid ID")
    func getMovieDetailsSuccess() async throws {
        let movieID = 76600
        
        let movie = try await sut.getDetails(id: movieID)
        
        #expect(movie.id == movieID)
        #expect(movie.title == "Avatar: The Way of Water")
        #expect(movie.overview.contains("Set more than a decade after the events"))
        #expect(movie.voteAverage == 7.7)
        #expect(movie.voteCount == 8932)
        #expect(movie.posterImage != nil, "Poster URL should be constructed correctly")
    }
    
    @Test("Get movie details with different movie IDs",
          arguments: [
              (movieID: 76600, expectedTitle: "Avatar: The Way of Water", expectedRating: 7.7),
              (movieID: 980078, expectedTitle: "The Last Kingdom: Seven Kings Must Die", expectedRating: 7.3),
              (movieID: 677179, expectedTitle: "Creed III", expectedRating: 7.2)
          ])
    func getMovieDetailsWithDifferentIDs(testData: (movieID: Int, expectedTitle: String, expectedRating: Double)) async throws {
        let movie = try await sut.getDetails(id: testData.movieID)
        
        #expect(movie.id == testData.movieID)
        #expect(movie.title == testData.expectedTitle)
        #expect(movie.voteAverage == testData.expectedRating)
        #expect(!movie.overview.isEmpty, "Overview should not be empty")
        #expect(movie.voteCount > 0, "Vote count should be positive")
    }
}

