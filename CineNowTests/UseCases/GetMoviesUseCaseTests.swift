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
struct GetMoviesUseCaseTests {
    
    var sut: GetMoviesUseCaseService
    
    init() {
        sut = withDependencies {
            $0.context = .test
        } operation: {
            GetMoviesUseCase()
        }
    }
    
}

// MARK: -

extension GetMoviesUseCaseTests {
        
    @Test("Get featured movies returns upcoming movies from page 1")
    func getFeaturedMovies() async throws {
        let movies = try await sut.getFeatured()
        
        #expect(movies.count == 7, "Should return 7 movies from mock data")
        #expect(!movies.isEmpty, "Movies array should not be empty")
        
        let firstMovie = movies.first!
        #expect(firstMovie.id == 76600)
        #expect(firstMovie.name == "Avatar: The Way of Water")
        #expect(firstMovie.voteAverage == 7.7)
    }
    
    @Test("Featured movies contain expected titles",
          arguments: [
              "Avatar: The Way of Water",
              "The Last Kingdom: Seven Kings Must Die",
              "Creed III",
              "Murder Mystery 2",
              "Evil Dead Rise",
              "Puss in Boots: The Last Wish",
              "John Wick: Chapter 4"
          ])
    func featuredMoviesContainExpectedTitle(expectedTitle: String) async throws {
        let movies = try await sut.getFeatured()
        
        let movieNames = movies.map(\.name)
        #expect(movieNames.contains(expectedTitle), "Should contain movie: \(expectedTitle)")
    }
    
}
