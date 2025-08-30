//
//  GameDetailResponse.swift
//  GimOn
//
//  Created by Enjel Hutasoit on 01/08/25.
//

import Foundation

struct GameDetailResponse: Decodable {
    
    let alternativeNames: [String]?
    let backgroundImage: String?
    let descriptionRaw: String?
    let developers: [Developer]?
    let esrbRating: ESRB?
    let genres: [Genre]?
    let id: Int
    let metacritic: Int?
    let metacriticURL: String?
    let name: String?
    let parentPlatforms: [ParentPlatform]?
    let playtime: Int?
    let rating: Double?
    let ratingsCount: Int?
    let redditURL: String?
    let released: String?
    let stores: [Store]?
    let tags: [Tag]?
    let website: String?
    
    enum CodingKeys: String, CodingKey {
        case alternativeNames = "alternative_names"
        case backgroundImage = "background_image"
        case descriptionRaw = "description_raw"
        case developers
        case esrbRating = "esrb_rating"
        case genres
        case id
        case metacritic
        case metacriticURL = "metacritic_url"
        case name
        case parentPlatforms = "parent_platforms"
        case playtime
        case rating
        case ratingsCount = "ratings_count"
        case redditURL = "reddit_url"
        case released
        case stores
        case tags
        case website
    }
}

struct Developer: Decodable {
    let name: String?
}

struct Store: Decodable {
    let storeDetail: StoreDetail?
    
    enum CodingKeys: String, CodingKey {
        case storeDetail = "store"
    }
}

struct StoreDetail: Decodable {
    let name: String?
    let domain: String?
}

struct Tag: Decodable {
    let name: String?
}

struct ESRB: Decodable {
    let name: String?
}
