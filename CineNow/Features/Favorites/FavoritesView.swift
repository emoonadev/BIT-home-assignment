//
//  FavoritesView.swift
//  CineNow
//
//  Created by Mickael Belhassen on 22/10/2025.
//

import ComposableArchitecture
import SwiftUI

struct FavoritesView: View {
    @Bindable var store: StoreOf<FavoritesFeature>

    var body: some View {
        NavigationStack {
            ZStack {
                if store.isLoading {
                    loadingView
                } else if store.favorites.isEmpty {
                    emptyStateView
                } else {
                    favoritesContent
                }
            }
            .navigationTitle("Favorites")
            .navigationDestination(item: $store.scope(state: \.movieDetailsState, action: \.movieDetailsAction)) { store in
                MovieDetailsView(store: store)
            }
            .onAppear {
                store.send(.onAppear)
            }
        }
    }
}

// MARK: -

private extension FavoritesView {
    
    var loadingView: some View {
        VStack(spacing: 20) {
            ProgressView()

            Text("Loading favorites...")
                .font(.headline)
                .foregroundColor(.secondary)
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel("Loading favorites")
    }

    var emptyStateView: some View {
        VStack(spacing: 24) {
            Image(systemName: "heart")
                .font(.system(size: 64))
                .foregroundColor(.gray)
                .accessibilityHidden(true)

            VStack(spacing: 8) {
                Text("No Favorites Yet")
                    .font(.title2)
                    .fontWeight(.semibold)

                Text("Movies you favorite will appear here")
                    .font(.body)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
            }
        }
        .padding()
        .accessibilityElement(children: .combine)
        .accessibilityLabel("No favorites yet. Movies you favorite will appear here")
    }

    var favoritesContent: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVGrid(columns: [
                GridItem(.flexible()),
                GridItem(.flexible()),
            ], spacing: 20) {
                ForEach(store.favorites, id: \.id) { movie in
                    Button {
                        store.send(.movieDidTap(movie))
                    } label: {
                        MovieRowView(movie: movie)
                    }
                }
            }
            .padding()
        }
    }
}

// MARK: - Preview

#Preview {
    FavoritesView(store: Store(initialState: FavoritesFeature.State()) {
        FavoritesFeature()
            .dependency(\.getFavoritesUseCase, DependencyValues.GetFavoritesUseCaseKey.previewValue)
    })
}
