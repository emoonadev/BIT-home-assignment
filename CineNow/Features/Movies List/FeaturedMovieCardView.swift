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
            posterImageView
            movieInfoView
        }
        .background(Color(.secondarySystemBackground))
        .cornerRadius(16)
        .shadow(color: .white.opacity(0.1), radius: 8, x: 0, y: 4)
        .accessibilityElement(children: .combine)
        .accessibilityLabel("Featured movie: \(movie.title), rated \(movie.voteAverage.formatted(.number.precision(.fractionLength(1)))) out of 10")
        .accessibilityHint("Double tap to view movie details")
    }
}

// MARK: -

private extension FeaturedMovieCardView {
    
    var posterImageView: some View {
        MovieImageView(imageURL: movie.posterImage)
            .scaledToFill()
            .frame(height: 200)
            .clipped()
            .overlay {
                VStack {
                    Image(systemName: "play.circle.fill")
                        .font(.system(size: 50))
                        .foregroundColor(.white)
                        .shadow(radius: 4)
                        .accessibilityHidden(true)
                }
            }
            .accessibilityHidden(true)
    }

    var movieInfoView: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                VStack(alignment: .leading, spacing: 6) {
                    Text(movie.title)
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
                Text(movie.releaseDate.formatted(date: .abbreviated, time: .omitted))
                    .font(.caption)
                    .foregroundColor(.secondary)

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .accessibilityHidden(true)
            }
        }
        .padding()
    }

    func ratingView(_ rating: Double, voteCount: Int) -> some View {
        let filledStars = Int(round((rating / 10) * 5))
        
        return HStack(spacing: 4) {
            ForEach(0..<5) { index in
                Image(systemName: index < filledStars ? "star.fill" : "star")
                    .font(.caption)
                    .foregroundColor(.yellow)
            }

            HStack(spacing: 2) {
                Text(rating.formatted(.number.precision(.fractionLength(1))))
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundColor(.primary)
                
                Text("/10")
                    .foregroundColor(.secondary)
                    .font(.caption)
            }

            Text("(\(voteCount))")
                .font(.caption2)
                .foregroundColor(.secondary)
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel("Rating \(rating.formatted(.number.precision(.fractionLength(1)))) out of 10, based on \(voteCount.formatted()) votes")
    }
}
