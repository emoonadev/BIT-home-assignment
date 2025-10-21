//
//  GetMoviesUseCase.swift
//  CineNow
//
//  Created by Mickael Belhassen on 21/10/2025.
//

import ComposableArchitecture
import Foundation

protocol GetMoviesUseCaseService {}

struct GetMoviesUseCase: UseCase, GetMoviesUseCaseService {
    @Dependency(\.networkManager) var networkManager: NetworkManagerService
    let apiController: APIRoute.Type = APIRoute.self
}

// MARK: API Controller

extension GetMoviesUseCase {
    
    enum APIRoute: APIController {
        case getList(atPage: Int)

        var route: String {
            switch self {
                case .getList: "movie/top_rated"
            }
        }

        var urlRequest: URLRequest {
            switch self {
                case let .getList(page): get(queryItems: URLQueryItem(name: "page", value: String(page)))
            }
        }
    }
    
}
