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
    
    @Test("Get upcoming movies returns expected movies from page 1")
    func getUpcomingMovies() async throws {
        let moviesResponse = try await sut.getList(for: .upcoming, page: 1)
        
        #expect(moviesResponse.results.count == 5, "Should return 5 movies from mock data")
        #expect(!moviesResponse.results.isEmpty, "Movies array should not be empty")
        
        let firstMovie = moviesResponse.results.first!
        #expect(firstMovie.id == 76600)
        #expect(firstMovie.title == "Avatar: The Way of Water")
        #expect(firstMovie.voteAverage == 7.7)
    }
    
    @Test("Upcoming movies contain expected titles",
          arguments: [
              "Avatar: The Way of Water",
              "The Last Kingdom: Seven Kings Must Die",
              "Creed III",
              "Murder Mystery 2",
              "Evil Dead Rise"
          ])
    func upcomingMoviesContainExpectedTitle(expectedTitle: String) async throws {
        let moviesResponse = try await sut.getList(for: .upcoming, page: 1)
        
        let movieNames = moviesResponse.results.map(\.title)
        #expect(movieNames.contains(expectedTitle), "Should contain movie: \(expectedTitle)")
    }
    
    @Test("Get top rated movies returns movies for category")
    func getTopRatedMovies() async throws {
        let moviesResponse = try await sut.getList(for: .topRated, page: 1)
        
        #expect(!moviesResponse.results.isEmpty, "Top rated movies should not be empty")
        #expect(moviesResponse.page == 1, "Should return page 1")
        
        let firstMovie = moviesResponse.results.first!
        #expect(firstMovie.voteAverage > 0, "Top rated movies should have positive ratings")
    }
    
    @Test("Get now playing movies returns movies for category")
    func getNowPlayingMovies() async throws {
        let moviesResponse = try await sut.getList(for: .nowPlaying, page: 1)
        
        #expect(!moviesResponse.results.isEmpty, "Now playing movies should not be empty")
        #expect(moviesResponse.page == 1, "Should return page 1")
        
        let firstMovie = moviesResponse.results.first!
        #expect(firstMovie.id > 0, "Movie should have valid ID")
        #expect(!firstMovie.title.isEmpty, "Movie should have title")
    }
    
    @Test("Get movies with different categories", arguments: [Movie.Category.upcoming, .topRated, .nowPlaying])
    func getMoviesWithDifferentCategories(category: Movie.Category) async throws {
        let moviesResponse = try await sut.getList(for: category, page: 1)
        
        #expect(!moviesResponse.results.isEmpty, "Should return movies for category: \(category)")
        #expect(moviesResponse.page == 1, "Should return correct page number")
        #expect(moviesResponse.totalPages == 1, "Should have 1 total page from mock")
        #expect(moviesResponse.results.count == 5, "Should have 5 movies from mock")
    }
    
}
