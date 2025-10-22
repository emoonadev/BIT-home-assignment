//
//  MovieDetailsView.swift
//  CineNow
//
//  Created by Mickael Belhassen on 22/10/2025.
//

import ComposableArchitecture
import SwiftUI

struct MovieDetailsView: View {
    let store: StoreOf<MovieDetailsFeature>

    var body: some View {
        ZStack {
            if store.isLoading {
                loadingView
            } else if let movie = store.movie {
                movieDetailsContent(movie)
            } else if store.errorMessage != nil {
                errorView
            }
        }
        .ignoresSafeArea()
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                favoriteButton
            }
        }
        .onAppear {
            store.send(.onAppear)
        }
        .refreshable {
            store.send(.refreshData)
        }
    }
}

// MARK: -

private extension MovieDetailsView {
    
    var favoriteButton: some View {
        Button {
            store.send(.toggleFavorite)
        } label: {
            Image(systemName: store.isFavorite ? "heart.fill" : "heart")
                .foregroundColor(store.isFavorite ? .red : .gray)
                .font(.title2)
        }
        .disabled(store.isTogglingFavorite)
        .accessibilityLabel(store.isFavorite ? "Remove from favorites" : "Add to favorites")
        .accessibilityHint("Double tap to toggle favorite status")
    }
    
    var loadingView: some View {
        VStack(spacing: 20) {
            ProgressView()
                .scaleEffect(1.5)

            Text("Loading movie details...")
                .font(.headline)
                .foregroundColor(.secondary)
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel("Loading movie details")
    }

    var errorView: some View {
        VStack(spacing: 24) {
            Image(systemName: "exclamationmark.triangle")
                .font(.system(size: 64))
                .foregroundColor(.red)
                .accessibilityHidden(true)

            VStack(spacing: 8) {
                Text("Error Loading Movie")
                    .font(.title2)
                    .fontWeight(.semibold)

                if let errorMessage = store.errorMessage {
                    Text(errorMessage)
                        .font(.body)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                }
            }

            Button("Try Again") {
                store.send(.loadMovieDetails(true))
            }
            .buttonStyle(.bordered)
        }
        .padding()
        .accessibilityElement(children: .combine)
        .accessibilityLabel("Error loading movie details")
    }

    func movieDetailsContent(_ movie: Movie) -> some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 24) {
                posterSection(movie)

                VStack {
                    movieInfoSection(movie)
                    overviewSection(movie)
                        .padding(.top)
                }
                .padding(.horizontal)
            }
        }
    }

    func posterSection(_ movie: Movie) -> some View {
        MovieImageView(imageURL: movie.posterImage)
            .scaledToFill()
            .frame(height: 400)
            .clipped()
            .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 5)
            .accessibilityElement()
            .accessibilityLabel("Movie poster for \(movie.title)")
    }

    func movieInfoSection(_ movie: Movie) -> some View {
        Group {
            Text(movie.title)
                .font(.largeTitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)

            HStack(spacing: 24) {
                releaseYearInfo(movie)
                Spacer()
                ratingInfo(movie)
            }
            .frame(maxWidth: .infinity)
            .padding(.top)
        }
    }

    func releaseYearInfo(_ movie: Movie) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Release Year")
                .font(.caption)
                .foregroundColor(.secondary)
                .fontWeight(.medium)

            Text(String(Calendar.current.component(.year, from: movie.releaseDate)))
                .font(.title2)
                .fontWeight(.semibold)
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel("Released in \(Calendar.current.component(.year, from: movie.releaseDate))")
    }

    func ratingInfo(_ movie: Movie) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Rating")
                .font(.caption)
                .foregroundColor(.secondary)
                .fontWeight(.medium)

            HStack(spacing: 4) {
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
                    .font(.caption)

                Text(movie.voteAverage.formatted(.number.precision(.fractionLength(1))))
                    .font(.title2)
                    .fontWeight(.semibold)

                Text("(\(movie.voteCount))")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel("Rating: \(movie.voteAverage.formatted(.number.precision(.fractionLength(1)))) stars out of 10, based on \(movie.voteCount) votes")
    }

    func overviewSection(_ movie: Movie) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Overview")
                .font(.headline)
                .fontWeight(.semibold)

            Text(movie.overview)
                .font(.body)
                .lineLimit(nil)
                .fixedSize(horizontal: false, vertical: true)
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel("Overview: \(movie.overview)")
    }
    
}

// MARK: - Preview

#Preview {
    NavigationStack {
        MovieDetailsView(store: Store(initialState: MovieDetailsFeature.State(movieID: 2222, isFavorite: false)) {
            MovieDetailsFeature()
                .dependency(\.getMovieDetailsUseCase, DependencyValues.GetMovieDetailsUseCaseKey.previewValue)
        })
    }
}
