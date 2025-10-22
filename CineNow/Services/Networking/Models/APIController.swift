//
//  APIRoute.swift
//  Fitness22
//
//  Created by Mickael Belhassen on 20/10/2025.
//

import Foundation

protocol APIController {
    var route: String { get }
    var urlRequest: URLRequest { get }
}

extension APIController {
    
    var baseURL: URL { URL(string: "https://api.themoviedb.org/3/")! }
    var baseHeaders: [String: String] {
        [
            "Content-Type": "application/json",
            "accept": "application/json"
        ]
    }

    func get(_ path: String..., queryItems: URLQueryItem...) -> URLRequest {
        return buildURLRequest(method: "GET", pathComponents: [route] + path, queryItems: queryItems, body: nil)
    }

    func put<T: Codable>(_ path: String..., body: T) -> URLRequest {
        let bodyData = try? encode(body)
        return buildURLRequest(method: "PUT", pathComponents: [route] + path, queryItems: [], body: bodyData)
    }

    func patch<T: Codable>(_ path: String..., body: T) -> URLRequest {
        let bodyData = try? encode(body)
        return buildURLRequest(method: "PATCH", pathComponents: [route] + path, queryItems: [], body: bodyData)
    }

    func post<T: Codable>(_ path: String..., body: T) -> URLRequest {
        let bodyData = try? encode(body)
        return buildURLRequest(method: "POST", pathComponents: [route] + path, queryItems: [], body: bodyData)
    }

    private func buildURLRequest(method: String, pathComponents: [String], queryItems: [URLQueryItem], body: [String: Any]?) -> URLRequest {
        var url = baseURL
        pathComponents.forEach { url.appendPathComponent($0) }
        
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
        urlComponents?.queryItems = queryItems
        
        var request = URLRequest(url: urlComponents!.url!)
        request.httpMethod = method
        request.allHTTPHeaderFields = baseHeaders
        
        if let body {
            request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        }
        
        return request
    }
    
    private func encode<T>(_ value: T) throws -> [String: Any] where T: Encodable {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        
        let jsonData = try encoder.encode(value)
        return try JSONSerialization.jsonObject(with: jsonData) as? [String: Any] ?? [:]
    }
}
