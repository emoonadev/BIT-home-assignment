//
//  MovieRemoteDataSource.swift
//  CineNow
//
//  Created by Mickael Belhassen on 21/10/2025.
//

import ComposableArchitecture
import Foundation

protocol MovieRemoteDataSourceService {
    func fetchPopular(at page: Int) async throws -> [Movie]
    func fetchDetails(id: Int) async throws -> Movie
}

struct MovieRemoteDataSource: RemoteDataSource, MovieRemoteDataSourceService {
    @Dependency(\.networkManager) var api: NetworkManagerService
    let controller: APIRoute.Type = APIRoute.self
}

// MARK: - CRUD

extension MovieRemoteDataSource {
    
    func fetchPopular(at page: Int) async throws -> [Movie] {
        let response: MoviesListResponseDTO = try await api.perform(controller.getPopular(page))
        return response.results
    }

    func fetchDetails(id: Int) async throws -> Movie {
        try await api.perform(controller.getDetails(id: id))
    }
    
}

// MARK: - Controller

extension MovieRemoteDataSource {
    
    enum APIRoute: APIController {
        case getPopular(_ page: Int)
        case getDetails(id: Int)

        var route: String {
            switch self {
                case .getPopular: "movie/popular"
                case let .getDetails(id): "movie/\(id)"
            }
        }

        var urlRequest: URLRequest {
            switch self {
                case let .getPopular(page): get(queryItems: URLQueryItem(name: "page", value: String(page)))
                case .getDetails: get()
            }
        }
    }
    
}
