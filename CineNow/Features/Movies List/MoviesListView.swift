//
//  MoviesListView.swift
//  CineNow
//
//  Created by Mickael Belhassen on 21/10/2025.
//

import ComposableArchitecture
import SwiftUI

struct MoviesListView: View {
    let store: StoreOf<MoviesListFeature>

    var body: some View {
        NavigationView {
            ZStack {
                if store.isLoading {
                    loadingView
                } else if store.movies.isEmpty {
                    emptyStateView
                } else {
                    moviesScrollView
                }
            }
            .navigationTitle("Movies")
            .onAppear {
                store.send(.onAppear)
            }
        }
    }
}

// MARK: - View Components

private extension MoviesListView {
    
    var loadingView: some View {
        VStack(spacing: 20) {
            ProgressView()

            Text("Loading movies...")
                .font(.headline)
                .foregroundColor(.secondary)
        }
    }

    var emptyStateView: some View {
        VStack(spacing: 24) {
            Image(systemName: "tv")
                .font(.system(size: 64))
                .foregroundColor(.gray)

            VStack(spacing: 8) {
                Text("No Movies Available")
                    .font(.title2)
                    .fontWeight(.semibold)

                Text("Check back later for new releases")
                    .font(.body)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
    }

    var moviesScrollView: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(spacing: 24) {
                featuredMovieCard

                VStack(alignment: .leading, spacing: 16) {
                    sectionHeader("Popular Movies")
                    popularMoviesGrid
                }
                .padding(.horizontal)
            }
            .padding(.top)
        }
    }

    var featuredMovieCard: some View {
        Group {
            if let featuredMovie = store.movies.first {
                Button {
                    store.send(.movieDidTap(featuredMovie))
                } label: {
                    FeaturedMovieCardView(movie: featuredMovie)
                        .padding(.horizontal)
                }
            }
        }
    }

    func sectionHeader(_ title: String) -> some View {
        HStack {
            Text(title)
                .font(.title2)
                .fontWeight(.bold)

            Spacer()
        }
    }

    var popularMoviesGrid: some View {
        LazyVGrid(columns: [
            GridItem(.flexible(), spacing: 12),
            GridItem(.flexible(), spacing: 12),
        ], spacing: 16) {
            ForEach(store.movies.dropFirst(), id: \.id) { movie in
                Button {
                    store.send(.movieDidTap(movie))
                } label: {
                    MovieRowView(movie: movie)
                }
                .frame(maxWidth: .infinity)
            }
        }
    }
}

// MARK: - Preview

#Preview {
    MoviesListView(store: Store(initialState: .init()) {
        MoviesListFeature()
            .dependency(\.getMoviesUseCase, DependencyValues.GetMoviesUseCaseKey.previewValue)
    })
}
