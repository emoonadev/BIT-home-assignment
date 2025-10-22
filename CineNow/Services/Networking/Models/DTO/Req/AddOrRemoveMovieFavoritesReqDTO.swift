//
//  MoviesListResponseDTO .swift
//  CineNow
//
//  Created by Mickael Belhassen on 21/10/2025.
//

struct AddOrRemoveMovieFavoritesReqDTO: Codable {
    let mediaId: Int
    let favorite: Bool
    let mediaType = "movie"
}
