//
//  GameListResponse.swift
//  GimOn
//
//  Created by Enjel Hutasoit on 31/07/25.
//

import Foundation

struct GameListResponse: Decodable {
    let games: [GameResponse]
    
    enum CodingKeys: String, CodingKey {
        case games = "results"
    }
}

struct GameResponse: Decodable {
    let backgroundImage: String?
    let genres: [Genre]?
    let id: Int
    let name: String?
    let parentPlatforms: [ParentPlatform]?
    let playtime: Int?
    let rating: Double?
    let ratingCount: Int?
    let released: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name, released, rating, playtime, genres
        case backgroundImage = "background_image"
        case ratingCount = "ratings_count"
        case parentPlatforms = "parent_platforms"
    }
}

struct Genre: Decodable {
    let name: String?
}

struct ParentPlatform: Decodable {
    let platform: Platform?
}

struct Platform: Decodable {
    let name: String?
    let slug: String?
}
