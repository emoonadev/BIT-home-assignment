//
//  MainView.swift
//  CineNow
//
//  Created by Mickael Belhassen on 21/10/2025.
//

import SwiftUI
import SwiftData
import ComposableArchitecture

struct MainView: View {
    @Bindable var store: StoreOf<MainFeature>

    var body: some View {
        TabView {
            Tab {
                MoviesListView(
                    store: store.scope(
                        state: \.moviesListState,
                        action: \.moviesListAction
                    )
                )
            } label: {
                Image(systemName: "house")
                Text("Movies")
            }
            
            Tab {
                Text("Favorite")
            } label: {
                Image(systemName: "star.fill")
                Text("Favorites")
            }
        }
    }
}
