//
//  GameMapper.swift
//  GimOn
//
//  Created by Enjel Hutasoit on 26/08/25.
//

import Foundation

final class GameMapper {
    static func gameMapper(
        input gameResponses: [GameResponse]
    ) -> [GameModel] {
        return gameResponses.map { item in
            return GameModel(
                backgroundImage: URL(string: item.backgroundImage ?? "") ?? URL(string: "")!,
                genres: item.genres?.compactMap { $0.name } ?? [],
                id: item.id,
                name: item.name ?? "-",
                parentPlatfroms: item.parentPlatforms?.compactMap { $0.platform?.slug } ?? [],
                playtime: item.playtime ?? 0,
                rating: item.rating ?? 0,
                ratingCount: item.ratingCount ?? 0,
                released: item.released ?? "-"
            )
        }
    }
    
    static func gameDetailMapper(
        input: GameDetailResponse
    ) -> GameDetailModel {
        return GameDetailModel(
            alternativeNames: input.alternativeNames ?? [],
            backgroundImage: URL(string: input.backgroundImage ?? ""),
            description: input.descriptionRaw ?? "",
            developers: input.developers?.compactMap { $0.name } ?? [],
            esrbRating: input.esrbRating.map { $0.name ?? "" } ?? "",
            genres: input.genres?.compactMap { $0.name } ?? [],
            id: input.id,
            metacritic: input.metacritic ?? 0,
            metacriticURL: URL(string: input.metacriticURL ?? ""),
            name: input.name ?? "",
            parentPlatforms: input.parentPlatforms?.compactMap { PlatformModel(name: $0.platform?.name ?? "", slug: $0.platform?.slug ?? "") } ?? [],
            playtime: input.playtime ?? 0,
            rating: input.rating ?? 0.0,
            ratingsCount: input.ratingsCount ?? 0,
            redditURL: URL(string: input.redditURL ?? ""),
            released: input.released ?? "",
            stores: input.stores?.compactMap { StoreModel(name: $0.storeDetail?.name ?? "", domain: $0.storeDetail?.domain ?? "") } ?? [],
            tags: input.tags?.compactMap { $0.name } ?? [],
            website: URL(string: input.website ?? "")
        )
    }
}
