//
//  MovieRowView.swift
//  CineNow
//
//  Created by Mickael Belhassen on 21/10/2025.
//

import SwiftUI

struct MovieRowView: View {
    let movie: Movie

    var body: some View {
        VStack(spacing: 0) {
            posterImageView
            movieInfoView
        }
        .background(Color(.secondarySystemBackground))
        .cornerRadius(12)
        .shadow(color: .white.opacity(0.08), radius: 6, x: 0, y: 3)
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(movie.title), rated \(movie.formattedVoteAverage) out of 10")
        .accessibilityHint("Double tap to view movie details")
    }
}

// MARK: -

private extension MovieRowView {
    
    var posterImageView: some View {
        MovieImageView(imageURL: movie.posterImage)
            .aspectRatio(2 / 3, contentMode: .fit)
            .accessibilityHidden(true)
    }

    var movieInfoView: some View {
        HStack {
            
            Text(movie.releaseDate.formatted(date: .numeric, time: .omitted))
                .font(.caption2)
                .foregroundColor(.secondary)
                .accessibilityLabel("Release date \(movie.releaseDate.formatted(date: .complete, time: .omitted))")
            
            Spacer()
            
            HStack(spacing: 4) {
                Image(systemName: "star.fill")
                    .font(.caption)
                    .foregroundColor(.yellow)

                HStack(spacing: 2) {
                    Text(movie.formattedVoteAverage)
                        .foregroundColor(.primary)
                        .font(.caption)
                        .fontWeight(.medium)
                    
                    Text("/10")
                        .foregroundColor(.secondary)
                        .font(.caption)
                }
            }
            .accessibilityElement(children: .combine)
            .accessibilityLabel("Rating \(movie.formattedVoteAverage) out of 10")
        }
        .padding(12)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
