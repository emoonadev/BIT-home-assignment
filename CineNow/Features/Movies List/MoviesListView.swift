//
//  MoviesListView.swift
//  CineNow
//
//  Created by Mickael Belhassen on 21/10/2025.
//

import ComposableArchitecture
import SwiftUI

struct MoviesListView: View {
    @Bindable var store: StoreOf<MoviesListFeature>

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                categories
                
                ZStack {
                    if store.isLoading {
                        loadingView
                    } else if store.movies.isEmpty {
                        emptyStateView
                    } else {
                        moviesScrollView
                    }
                }
                .frame(maxHeight: .infinity)
            }
            .navigationTitle("Movies")
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

private extension MoviesListView {
    
    var categories: some View {
        Picker("Movie Category", selection: Binding(
            get: { store.selectedCategory },
            set: { store.send(.categoryDidChange($0)) }
        )) {
            ForEach(Movie.Category.allCases, id: \.self) { category in
                Text(category.displayName)
            }
        }
        .pickerStyle(.segmented)
        .padding(.horizontal, 16)
        .padding(.bottom, 16)
        .accessibilityLabel("Movie categories")
        .accessibilityHint("Select a category to filter movies")
        .accessibilityValue("Currently selected: \(store.selectedCategory.displayName)")
    }
    
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
        ScrollViewReader { proxy in
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack(spacing: 32) {
                    featuredMovieCard
                    
                    upcomingMoviesGrid(proxy)
                        .padding(.horizontal)
                    
                    if store.isLoadingMore {
                        loadingMoreIndicator
                    }
                }
                .padding(.top)
            }
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

    func upcomingMoviesGrid(_ proxy: ScrollViewProxy) -> some View {
        LazyVGrid(columns: [
            GridItem(.flexible()),
            GridItem(.flexible()),
        ], spacing: 20) {
            ForEach(store.movies.dropFirst(), id: \.id) { movie in
                Button {
                    store.send(.movieDidTap(movie))
                } label: {
                    MovieRowView(movie: movie)
                }
                .id(movie.id)
                .frame(maxWidth: .infinity)
                .onAppear {
                    store.send(.movieAppearedNearEnd(movie))
                }
            }
        }
        .onChange(of: store.selectedCategory) { _, _ in
            proxy.scrollTo(store.currentCategoryState.currentMovieID, anchor: .bottom)
        }
    }
    
    var loadingMoreIndicator: some View {
        HStack(spacing: 12) {
            ProgressView()
                .scaleEffect(0.8)
            
            Text("Loading more movies...")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding()
        .accessibilityElement(children: .combine)
        .accessibilityLabel("Loading more movies")
    }
}

// MARK: - Preview

#Preview {
    MoviesListView(store: Store(initialState: .init()) {
        MoviesListFeature()
            .dependency(\.getMoviesUseCase, DependencyValues.GetMoviesUseCaseKey.previewValue)
    })
}
