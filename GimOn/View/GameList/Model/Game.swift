//
//  Game.swift
//  GimOn
//
//  Created by Enjel Hutasoit on 31/07/25.
//

import Foundation

struct Game: Identifiable, Hashable {
    private let playtimeRaw: Int
    private let ratingCountRaw: Int
    private let ratingRaw: Double
    private let releasedRaw: String
    var id: Int
    let name: String
    var released: String { formatYear(from: releasedRaw) }
    let backgroundImage: URL
    var rating: String { String(format: "%.1f", ratingRaw) }
    var ratingCount: String {
        let num = Double(ratingCountRaw)
        switch num {
        case 1_000_000...:
            return String(format: "%.1fM", num / 1_000_000).replacingOccurrences(of: ".0", with: "")
        case 1_000...:
            return String(format: "%.1fk", num / 1_000).replacingOccurrences(of: ".0", with: "")
        default:
            return "\(ratingCountRaw)"
        }
    }
    let parentPlatforms: [String]
    var playtime: String { "\(playtimeRaw)h" }
    let genres: [String]
    
    init(
        backgroundImage: URL,
        genres: [String],
        id: Int,
        name: String,
        parentPlatfroms: [String],
        playtime: Int,
        rating: Double,
        ratingCount: Int,
        released: String
    ) {
        self.backgroundImage = backgroundImage
        self.genres = genres
        self.id = id
        self.name = name
        self.parentPlatforms = parentPlatfroms
        self.playtimeRaw = playtime
        self.ratingRaw = rating
        self.ratingCountRaw = ratingCount
        self.releasedRaw = released
    }
    
    private func formatYear(from dateString: String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        
        guard let date = inputFormatter.date(from: dateString) else {
            return ""
        }
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "yyyy"
        
        return outputFormatter.string(from: date)
    }
}
