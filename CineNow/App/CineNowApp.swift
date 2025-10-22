//
//  CineNowApp.swift
//  CineNow
//
//  Created by Mickael Belhassen on 21/10/2025.
//

import SwiftUI
import SwiftData
import ComposableArchitecture

@main
struct CineNowApp: App {
    let store = Store<MainFeature.State, MainFeature.Action>.withContext(initialState: MainFeature.State()) {
        MainFeature()
    }
    
    init() {
        setup()
    }

    var body: some Scene {
        WindowGroup {
            MainView(store: store)
                .preferredColorScheme(.dark)
        }
        .modelContainer(sharedModelContainer)
    }
}

// MARK: - Configurations

extension CineNowApp {
    
    func setup() {
        ImageCacheManager.configure()
    }
    
}
