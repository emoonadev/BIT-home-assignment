//
//  ServiceDependencyValues.swift
//  CineNow
//
//  Created by Mickael Belhassen on 21/10/2025.
//

import Foundation
import ComposableArchitecture


extension DependencyValues {
    
    // MARK: - Networking
    
    var networkManager: NetworkManagerService {
        get { self[NetworkManagerKey.self] }
        set { self[NetworkManagerKey.self] = newValue }
    }
    
}


// MARK: - Networking Keys

private enum NetworkManagerKey: DependencyKey {
    static let liveValue: NetworkManagerService = NetworkManager()
}

