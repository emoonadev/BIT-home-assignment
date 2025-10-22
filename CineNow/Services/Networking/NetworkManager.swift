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
        dateFormatter.dateFormat = "yyyy-MM-dd"
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        decoder.keyDecodingStrategy = .convertFromSnakeCase
    }
    
}

// MARK: -

extension NetworkManager {
    
    func perform<Model: Codable>(_ route: APIController) async throws -> Model {
        var request = route.urlRequest
        
        request.setValue("Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJlN2UyMzllMjYxZDBhYTc2NzllNWMwYWU1NDQ1YWQ3ZSIsIm5iZiI6MTc2MTEzMDU4OC40Miwic3ViIjoiNjhmOGI4NWMxNTUyZTlhNDkyZDNiYWJjIiwic2NvcGVzIjpbImFwaV9yZWFkIl0sInZlcnNpb24iOjF9._0NaMcrgD3AkyZ8NoJA0MVn50fTSVGJI42-0cksNsYo", forHTTPHeaderField: "Authorization")
        
        let (data, _) = try await session.data(for: request)
        return try decoder.decode(Model.self, from: data)
    }
    
}
