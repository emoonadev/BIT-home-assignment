//
//  CN+DateFormatter.swift
//  CineNow
//
//  Created by Mickael Belhassen on 21/10/2025.
//

import Foundation

extension DateFormatter {
    
    static let tmdbFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
}
