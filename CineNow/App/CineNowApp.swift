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
    let store = Store<MainFeature.State, MainFeature.Action>.withContext(context: .test, initialState: MainFeature.State()) {
        MainFeature()
    }
    
    init() {
        setup()
    }
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
//            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            MainView(store: store)
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
