//
//  GameDetail.swift
//  GimOn
//
//  Created by Enjel Hutasoit on 01/08/25.
//

import Foundation

struct GameDetail {
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
    var playtime: String
    var rating: String
    var ratingCount: String
    let redditURL: URL?
    var released: String
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
        self.playtime = formatPlaytime(playtime)
        self.rating = formatRating(rating)
        self.ratingCount = formatRatingCount(ratingsCount)
        self.redditURL = redditURL
        self.released = formatYear(from: released, to: "dd MMM yyyy")
        self.stores = stores
        self.tags = tags
        self.website = website
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
