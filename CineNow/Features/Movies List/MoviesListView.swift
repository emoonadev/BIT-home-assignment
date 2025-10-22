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
        NavigationStack {
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
        .accessibilityElement(children: .combine)
        .accessibilityLabel("Loading movies")
    }

    var emptyStateView: some View {
        VStack(spacing: 24) {
            Image(systemName: "tv")
                .font(.system(size: 64))
                .foregroundColor(.gray)
                .accessibilityHidden(true)

            VStack {
                Text("No Movies Available")
                    .font(.title2)
                    .fontWeight(.semibold)

                Text("Check back later for new releases")
                    .font(.body)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .accessibilityElement(children: .combine)
        .accessibilityLabel("No movies available. Check back later for new releases")
    }

    var moviesScrollView: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(spacing: 32) {
                featuredMovieCard

                VStack(alignment: .leading, spacing: 16) {
                    sectionHeader("Popular Movies")
                    popularMoviesGrid
                }
                .padding(.horizontal, 16)
            }
            .padding(.top, 16)
        }
    }

    var featuredMovieCard: some View {
        Group {
            if let featuredMovie = store.movies.first {
                Button {
                    store.send(.movieDidTap(featuredMovie))
                } label: {
                    FeaturedMovieCardView(movie: featuredMovie)
                        .padding(.horizontal, 16)
                }
                .buttonStyle(PlainButtonStyle())
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
        .accessibilityAddTraits(.isHeader)
    }

    var popularMoviesGrid: some View {
        LazyVGrid(columns: [
            GridItem(.flexible(), spacing: 16),
            GridItem(.flexible(), spacing: 16),
        ], spacing: 20) {
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