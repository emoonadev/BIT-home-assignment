//
//  MovieRemoteDataSource.swift
//  CineNow
//
//  Created by Mickael Belhassen on 21/10/2025.
//

import ComposableArchitecture
import Foundation

protocol MovieRemoteDataSourceService {
    func fetchUpcoming(at page: Int) async throws -> MoviesListResponseDTO
    func fetchTopRated(at page: Int) async throws -> MoviesListResponseDTO
    func fetchNowPlaying(at page: Int) async throws -> MoviesListResponseDTO
    func fetchDetails(id: Int) async throws -> Movie
    func fetchFavorites(at page: Int) async throws -> MoviesListResponseDTO
    func addToFavorites(_ movieID: Int) async throws
    func removeFromFavorites(_ movieID: Int) async throws
}

struct MovieRemoteDataSource: RemoteDataSource, MovieRemoteDataSourceService {
    @Dependency(\.networkManager) var api: NetworkManagerService
    let controller: APIRoute.Type = APIRoute.self
}

// MARK: - CRUD

extension MovieRemoteDataSource {
    
    func fetchUpcoming(at page: Int) async throws -> MoviesListResponseDTO {
        try await fetchList(route: controller.getUpcoming(page))
    }
    
    func fetchTopRated(at page: Int) async throws -> MoviesListResponseDTO {
        try await fetchList(route: controller.getTopRated(page))
    }
    
    func fetchNowPlaying(at page: Int) async throws -> MoviesListResponseDTO {
        try await fetchList(route: controller.getNowPlaying(page))
    }

    func fetchDetails(id: Int) async throws -> Movie {
        try await api.perform(controller.getDetails(id: id))
    }

    func fetchFavorites(at page: Int) async throws -> MoviesListResponseDTO {
        try await fetchList(route: controller.getFavorites(page))
    }

    func addToFavorites(_ movieID: Int) async throws {
        let _: Nothing = try await api.perform(controller.addToFavorites(AddOrRemoveMovieFavoritesReqDTO(mediaId: movieID, favorite: true)))
    }

    func removeFromFavorites(_ movieID: Int) async throws {
        let _: Nothing = try await api.perform(controller.removeFromFavorites(AddOrRemoveMovieFavoritesReqDTO(mediaId: movieID, favorite: false)))
    }
}

// MARK: - Helpers

private extension MovieRemoteDataSource {
    
    func fetchList(route: APIRoute) async throws -> MoviesListResponseDTO {
        let response: MoviesListResponseDTO = try await api.perform(route)
        return response
    }
    
}

// MARK: - Controller

extension MovieRemoteDataSource {
    
    enum APIRoute: APIController {
        case getUpcoming(_ page: Int)
        case getTopRated(_ page: Int)
        case getNowPlaying(_ page: Int)
        case getDetails(id: Int)
        case getFavorites(_ page: Int)
        case addToFavorites(AddOrRemoveMovieFavoritesReqDTO)
        case removeFromFavorites(AddOrRemoveMovieFavoritesReqDTO)

        var route: String {
            switch self {
                case .getUpcoming: "movie/upcoming"
                case .getTopRated: "movie/top_rated"
                case .getNowPlaying: "movie/now_playing"
                case let .getDetails(id): "movie/\(id)"
                case .getFavorites: "account/22403803/favorite/movies"
                case .addToFavorites, .removeFromFavorites: "account/22403803/favorite"
            }
        }

        var urlRequest: URLRequest {
            switch self {
                case let .getUpcoming(page):
                    get(queryItems: URLQueryItem(name: "page", value: String(page)))
                case let .getTopRated(page):
                    get(queryItems: URLQueryItem(name: "page", value: String(page)))
                case let .getNowPlaying(page):
                    get(queryItems: URLQueryItem(name: "page", value: String(page)))
                case let .getFavorites(page):
                    get(queryItems: URLQueryItem(name: "page", value: String(page)))
                case .getDetails:
                    get()
                case let .addToFavorites(dto), let .removeFromFavorites(dto):
                    post(body: dto)
            }
        }
    }
}
