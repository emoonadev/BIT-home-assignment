//
//  ContentView.swift
//  CineNow
//
//  Created by Mickael Belhassen on 21/10/2025.
//

import SwiftUI
import SwiftData
import ComposableArchitecture

struct MainView: View {

    var body: some View {
        TabView {
            Tab {
                MoviesListView(store: Store(initialState: .init()) {
                        MoviesListFeature()
                    }
                )
            } label: {
                Image(systemName: "house")
            }
            
            Tab {
                Text("Favorite")
            } label: {
                Image(systemName: "star.fill")
            }
        }
    }

}

#Preview {
    MainView()
}
