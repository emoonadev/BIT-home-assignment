//
//  MoviesListResponseDTO .swift
//  CineNow
//
//  Created by Mickael Belhassen on 21/10/2025.
//

struct MoviesListResponseDTO: Codable {
    let results: [Movie]
    let page: Int
    let totalPages: Int
}
