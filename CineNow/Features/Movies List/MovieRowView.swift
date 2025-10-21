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
    }
}

// MARK: -

private extension MovieRowView {
    
    var posterImageView: some View {
        MovieImageView(imageURL: movie.posterImage)
            .aspectRatio(2 / 3, contentMode: .fit)
            .overlay {
                VStack {
                    Spacer()
                    Image(systemName: "play.fill")
                        .font(.title2)
                        .foregroundColor(.white)
                        .shadow(radius: 2)
                    Spacer()
                }
            }
    }

    var movieInfoView: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(movie.name)
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundColor(.primary)
                .lineLimit(2)
                .multilineTextAlignment(.leading)
            
            HStack(spacing: 4) {
                Image(systemName: "star.fill")
                    .font(.caption)
                    .foregroundColor(.yellow)

                Text(movie.voteAverage.formatted())
                    .font(.caption)
                    .fontWeight(.medium)
            }
            
            Text(movie.createdAt.formatted())
                .font(.caption2)
                .foregroundColor(.secondary)
        }
        .padding(12)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
}
