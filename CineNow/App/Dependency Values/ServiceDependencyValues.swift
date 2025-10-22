//
//  ServiceDependencyValues.swift
//  CineNow
//
//  Created by Mickael Belhassen on 21/10/2025.
//

import Foundation
import ComposableArchitecture

// MARK: - Keys

extension DependencyValues {
        
    var networkManager: NetworkManagerService {
        get { self[NetworkManagerKey.self] }
        set { self[NetworkManagerKey.self] = newValue }
    }
    
}

// MARK: -

extension DependencyValues {
    
    // MARK: - Networking

    fileprivate enum NetworkManagerKey: DependencyKey {
        static let liveValue: NetworkManagerService = NetworkManager()
        static let testValue: NetworkManagerService = NetworkManager()
        static let previewValue: NetworkManagerService = NetworkManager()
    }
    
}

