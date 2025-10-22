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
        .shadow(color: .black.opacity(0.08), radius: 6, x: 0, y: 3)
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(movie.title), rated \(movie.voteAverage.formatted(.number.precision(.fractionLength(1)))) out of 10")
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
        VStack(alignment: .leading) {
            HStack(spacing: 4) {
                Image(systemName: "star.fill")
                    .font(.caption)
                    .foregroundColor(.yellow)

                Text(movie.voteAverage.formatted(.number.precision(.fractionLength(1))))
                    .font(.caption)
                    .fontWeight(.medium)
            }
            .accessibilityElement(children: .combine)
            .accessibilityLabel("Rating \(movie.voteAverage.formatted(.number.precision(.fractionLength(1)))) out of 10")
            
            Text(movie.releaseDate.formatted(date: .abbreviated, time: .omitted))
                .font(.caption2)
                .foregroundColor(.secondary)
                .accessibilityLabel("Release date \(movie.releaseDate.formatted(date: .complete, time: .omitted))")
        }
        .padding(12)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
