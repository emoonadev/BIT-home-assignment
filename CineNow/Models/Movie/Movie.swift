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
}
