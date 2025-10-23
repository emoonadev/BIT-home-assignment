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
    let releaseDate: Date
    let title: String
    let voteCount: Int
    let voteAverage: Double
    
    private let posterPath: String

    var formattedVoteAverage: String {
        voteAverage
            .formatted(
                .number.precision(
                    .integerAndFractionLength(integerLimits: 1..., fractionLimits: 0...2)
                )
            )
    }

    var posterImage: URL? { URL(string: "https://image.tmdb.org/t/p/w500" + posterPath) }

    init(id: Int, overview: String, releaseDate: Date, title: String, voteAverage: Double, voteCount: Int, posterPath: String) {
        self.id = id
        self.overview = overview
        self.releaseDate = releaseDate
        self.title = title
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
