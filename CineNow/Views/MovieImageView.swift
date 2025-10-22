//
//  Untitled.swift
//  CineNow
//
//  Created by Mickael Belhassen on 21/10/2025.
//

import Kingfisher
import SwiftUI

struct MovieImageView: View {
    let imageURL: URL?

    var body: some View {
        Group {
            if let url = imageURL {
                image(with: url)
            } else {
                placeholder
            }
        }
        .cornerRadius(12)
    }

    func image(with url: URL) -> some View {
        KFImage(url)
            .placeholder {
                placeholder
            }
            .retry(maxCount: 2, interval: .seconds(1))
            .resizable()
            .clipped()
    }

    var placeholder: some View {
        Rectangle()
            .fill(.gray.opacity(0.5))
            .overlay {
                Image(systemName: "photo")
                    .font(.title2)
            }
    }
}

#Preview {
    MovieImageView(imageURL: URL(string: "https://image.tmdb.org/t/p/w500/t6HIqrRAclMCA60NsSmeqe9RmNV.jpg"))
        .frame(width: 200, height: 300)
}
