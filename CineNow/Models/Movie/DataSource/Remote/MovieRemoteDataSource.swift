//
//  MovieRemoteDataSource.swift
//  CineNow
//
//  Created by Mickael Belhassen on 21/10/2025.
//

import ComposableArchitecture
import Foundation

protocol MovieRemoteDataSourceService {
    func fetchUpcoming(at page: Int) async throws -> [Movie]
    func fetchTopRated(at page: Int) async throws -> [Movie]
    func fetchNowPlaying(at page: Int) async throws -> [Movie]
    func fetchDetails(id: Int) async throws -> Movie
}

struct MovieRemoteDataSource: RemoteDataSource, MovieRemoteDataSourceService {
    @Dependency(\.networkManager) var api: NetworkManagerService
    let controller: APIRoute.Type = APIRoute.self
}

// MARK: - CRUD

extension MovieRemoteDataSource {
    
    func fetchUpcoming(at page: Int) async throws -> [Movie] {
        try await fetchList(route: controller.getUpcoming(page))
    }
    
    func fetchTopRated(at page: Int) async throws -> [Movie] {
        try await fetchList(route: controller.getTopRated(page))
    }
    
    func fetchNowPlaying(at page: Int) async throws -> [Movie] {
        try await fetchList(route: controller.getNowPlaying(page))
    }

    func fetchDetails(id: Int) async throws -> Movie {
        try await api.perform(controller.getDetails(id: id))
    }
}

// MARK: - Helpers

private extension MovieRemoteDataSource {
    
    func fetchList(route: APIRoute) async throws -> [Movie] {
        let response: MoviesListResponseDTO = try await api.perform(route)
        return response.results
    }
    
}

// MARK: - Controller

extension MovieRemoteDataSource {
    
    enum APIRoute: APIController {
        case getUpcoming(_ page: Int)
        case getTopRated(_ page: Int)
        case getNowPlaying(_ page: Int)
        case getDetails(id: Int)

        var route: String {
            switch self {
                case .getUpcoming: "movie/upcoming"
                case .getTopRated: "movie/top_rated"
                case .getNowPlaying: "movie/now_playing"
                case let .getDetails(id): "movie/\(id)"
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
                case .getDetails:
                    get()
            }
        }
    }
}
