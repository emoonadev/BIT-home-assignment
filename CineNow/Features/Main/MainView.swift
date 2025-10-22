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
        NavigationStack {
            TabView(selection: Binding(
                get: { store.selectedTab },
                set: { store.send(.tabSelected($0)) }
            )) {
                Tab(value: MainFeature.Tab.movies) {
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

                Tab(value: MainFeature.Tab.favorites) {
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
            .navigationTitle(store.navigationTitle)
            .navigationDestination(item: $store.scope(state: \.movieDetailsState, action: \.movieDetailsAction)) { store in
                MovieDetailsView(store: store)
            }
        }
    }
}
