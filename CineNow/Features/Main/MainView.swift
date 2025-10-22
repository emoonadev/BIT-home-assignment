//
//  MainView.swift
//  CineNow
//
//  Created by Mickael Belhassen on 21/10/2025.
//

import ComposableArchitecture
import SwiftData
import SwiftUI

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
                Text(MainFeature.Tab.movies.title)
            }

            Tab {
                FavoritesView(
                    store: store.scope(
                        state: \.favoritesState,
                        action: \.favoritesAction
                    )
                )
            } label: {
                Image(systemName: "star.fill")
                Text(MainFeature.Tab.favorites.title)
            }
        }
    }
}
