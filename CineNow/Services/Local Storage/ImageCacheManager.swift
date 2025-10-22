//
//  ImageCacheManager.swift
//  CineNow
//
//  Created by Mickael Belhassen on 21/10/2025.
//

import Foundation
import Kingfisher

struct ImageCacheManager {
    
    private init() {}
    
    static func configure() {
        ImageCache.default.diskStorage.config.expiration = .days(1)
        ImageCache.default.memoryStorage.config.expiration = .seconds(3600) // 1h
    }
    
}
