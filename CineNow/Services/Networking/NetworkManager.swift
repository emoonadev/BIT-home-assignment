//
//  NetworkManager.swift
//  CineNow
//
//  Created by Mickael Belhassen on 21/10/2025.
//

import Foundation
import ComposableArchitecture

protocol NetworkManagerService {
    func perform<Model: Codable>(_ route: APIController) async throws -> Model
}

final class NetworkManager: NetworkManagerService {
    let session: URLSession
    let decoder: JSONDecoder

    init(session: URLSession = .shared, decoder: JSONDecoder = JSONDecoder()) {
        self.session = session
        self.decoder = decoder
        setup()
    }
    
}

// MARK: - Setup

private extension NetworkManager {
    
    func setup() {
        setupDecoder()
    }
    
    func setupDecoder() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        decoder.keyDecodingStrategy = .convertFromSnakeCase
    }
    
}

// MARK: -

extension NetworkManager {
    
    func perform<Model: Codable>(_ route: APIController) async throws -> Model {
        let (data, _) = try await session.data(for: route.urlRequest)
        return try decoder.decode(Model.self, from: data)
    }
    
}
