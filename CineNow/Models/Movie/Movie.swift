//
//  Movie.swift
//  CineNow
//
//  Created by Mickael Belhassen on 21/10/2025.
//

import Foundation

struct Movie: Codable {
    let id: Int
    let overview: String
    let createdAt: Date
    let name: String
    let voteAverage: Double
    let voteCount: Int
    private let posterPath: String
    
    var posterImage: URL? { URL(string: "https://image.tmdb.org/t/p/w500" + posterPath) }

    init(id: Int, overview: String, createdAt: Date, name: String, voteAverage: Double, voteCount: Int, posterPath: String) {
        self.id = id
        self.overview = overview
        self.createdAt = createdAt
        self.name = name
        self.voteAverage = voteAverage
        self.voteCount = voteCount
        self.posterPath = posterPath
    }
}

// MARK: -

extension Movie {
    
    enum Category: String, CaseIterable {
        case upcoming, topRated, nowPlaying
        
        var displayName: String {
            return switch self {
                case .upcoming: "Upcoming"
                case .topRated: "Top Rated"
                case .nowPlaying: "Now Playing"
            }
        }
    }
    
}
