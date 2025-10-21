//
//  FeaturedMovieCardView.swift
//  CineNow
//
//  Created by Mickael Belhassen on 21/10/2025.
//

import SwiftUI

struct FeaturedMovieCardView: View {
    let movie: Movie

    var body: some View {
        VStack(spacing: 0) {
            MovieImageView(imageURL: movie.posterImage)
                .frame(height: 200)
                .overlay {
                    VStack {
                        Image(systemName: "play.circle.fill")
                            .font(.system(size: 50))
                            .foregroundColor(.white)
                            .shadow(radius: 4)
                    }
                }

            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(movie.name)
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                            .multilineTextAlignment(.leading)

                        ratingView(movie.voteAverage, voteCount: movie.voteCount)
                    }

                    Spacer()
                }

                Text(movie.overview)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(3)
                    .multilineTextAlignment(.leading)

                HStack {
                    Text(movie.createdAt.formatted())
                        .font(.caption)
                        .foregroundColor(.secondary)

                    Spacer()

                    Image(systemName: "chevron.right")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            .padding(16)
        }
        .background(Color(.secondarySystemBackground))
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)
    }

    func ratingView(_ rating: Double, voteCount: Int) -> some View {
        HStack(spacing: 4) {
            ForEach(0..<5) { index in
                Image(systemName: index < Int(rating / 2) ? "star.fill" : "star")
                    .font(.caption)
                    .foregroundColor(.yellow)
            }

            Text(String(format: "%.1f", rating))
                .font(.caption)
                .fontWeight(.medium)
                .foregroundColor(.primary)

            Text("(\(voteCount))")
                .font(.caption2)
                .foregroundColor(.secondary)
        }
    }
}
