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
}
