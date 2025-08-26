//
//  GameModel.swift
//  GimOn
//
//  Created by Enjel Hutasoit on 31/07/25.
//

import Foundation

struct GameModel: Identifiable, Hashable {
    var id: Int
    let name: String
    var released: String
    let backgroundImage: URL
    var rating: String
    var ratingCount: String
    let parentPlatforms: [String]
    var playtime: String
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
        self.playtime = formatPlaytime(playtime)
        self.rating = formatRating(rating)
        self.ratingCount = formatRatingCount(ratingCount)
        self.released = formatYear(from: released)
    }
}

extension GameModel {
    init(
        backgroundImage: URL,
        genres: [String],
        id: Int,
        name: String,
        parentPlatfroms: [String],
        formattedPlaytime: String,
        formattedRating: String,
        formattedRatingCount: String,
        formattedReleased: String
    ) {
        self.backgroundImage = backgroundImage
        self.genres = genres
        self.id = id
        self.name = name
        self.parentPlatforms = parentPlatfroms
        self.playtime = formattedPlaytime
        self.rating = formattedRating
        self.ratingCount = formattedRatingCount
        self.released = formattedReleased
    }

    init(from favorite: FavoriteGame) {
        self.init(
            backgroundImage: URL(string: favorite.backgroundImage ?? "") ?? URL(string: "")!,
            genres: favorite.genres ?? [],
            id: Int(favorite.id),
            name: favorite.name ?? "",
            parentPlatfroms: favorite.parentPlatforms ?? [],
            formattedPlaytime: favorite.playtime ?? "",
            formattedRating: favorite.rating ?? "",
            formattedRatingCount: favorite.ratingCount ?? "",
            formattedReleased: formatYear(from: favorite.released ?? "", inputDateFormat: "dd MMM yyy")
        )
    }
}
