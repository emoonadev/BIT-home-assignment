//
//  MoviesListResponseDTO .swift
//  CineNow
//
//  Created by Mickael Belhassen on 21/10/2025.
//

struct MoviesListResponseDTO: Codable {
    let page: Int
    let results: [Movie]
}
