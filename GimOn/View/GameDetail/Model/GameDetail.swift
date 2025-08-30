//
//  GameDetail.swift
//  GimOn
//
//  Created by Enjel Hutasoit on 01/08/25.
//

import Foundation

struct GameDetail {
    private let playtimeRaw: Int
    private let ratingsCountRaw: Int
    private let ratingRaw: Double
    private let releasedRaw: String
    let alternativeNames: [String]
    let backgroundImage: URL?
    let description: String
    let developers: [String]
    let esrbRating: String
    let genres: [String]
    let metacritic: Int
    let metacriticURL: URL?
    let name: String
    let parentPlatforms: [PlatformModel]
    var playtime: String { "\(playtimeRaw)h" }
    var rating: String { String(format: "%.1f", ratingRaw) }
    var ratingCount: String {
        let num = Double(ratingsCountRaw)
        switch num {
        case 1_000_000...:
            return String(format: "%.1fM", num / 1_000_000).replacingOccurrences(of: ".0", with: "")
        case 1_000...:
            return String(format: "%.1fk", num / 1_000).replacingOccurrences(of: ".0", with: "")
        default:
            return "\(ratingsCountRaw)"
        }
    }
    let redditURL: URL?
    var released: String { formatYear(from: releasedRaw) }
    let tags: [String]
    let website: URL?
    let stores: [StoreModel]?
    
    init(
        alternativeNames: [String],
        backgroundImage: URL?,
        description: String,
        developers: [String],
        esrbRating: String,
        genres: [String],
        metacritic: Int,
        metacriticURL: URL?,
        name: String,
        parentPlatforms: [PlatformModel],
        playtime: Int,
        rating: Double,
        ratingsCount: Int,
        redditURL: URL?,
        released: String,
        stores: [StoreModel]?,
        tags: [String],
        website: URL?
    ) {
        self.alternativeNames = alternativeNames
        self.backgroundImage = backgroundImage
        self.description = description
        self.developers = developers
        self.esrbRating = esrbRating
        self.genres = genres
        self.metacritic = metacritic
        self.metacriticURL = metacriticURL
        self.name = name
        self.parentPlatforms = parentPlatforms
        self.playtimeRaw = playtime
        self.ratingRaw = rating
        self.ratingsCountRaw = ratingsCount
        self.redditURL = redditURL
        self.releasedRaw = released
        self.stores = stores
        self.tags = tags
        self.website = website
    }
    
    private func formatYear(from dateString: String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        
        guard let date = inputFormatter.date(from: dateString) else {
            return ""
        }
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "dd MMM yyyy"
        
        return outputFormatter.string(from: date)
    }
}

struct PlatformModel: Hashable {
    let name: String
    let slug: String
}

struct StoreModel: Hashable {
    let name: String
    let domain: String?
}
