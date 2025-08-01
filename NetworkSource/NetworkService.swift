//
//  NetworkService.swift
//  GimOn
//
//  Created by Enjel Hutasoit on 31/07/25.
//

import Foundation

class NetworkService {
    
    let apiKey = Constants.apiKey
    let pageSize = "35"
    
    func getGames() async throws -> [Game] {
        var components = URLComponents(string: "https://api.rawg.io/api/games")!
        components.queryItems = [
            URLQueryItem(name: "key", value: apiKey),
            URLQueryItem(name: "page_size", value: pageSize)
            
        ]
        let request = URLRequest(url: components.url!)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            fatalError("Error: Can't fetching data.")
        }
        
        let decoder = JSONDecoder()
        let result = try decoder.decode(GameListResponse.self, from: data)
        
        return gameMapper(input: result.games)
    }
    
    func getGame(id: Int) async throws -> GameDetail {
        var components = URLComponents(string: "https://api.rawg.io/api/games/\(id)")!
        components.queryItems = [
            URLQueryItem(name: "key", value: apiKey)
        ]
        let request = URLRequest(url: components.url!)
        let (data, response) = try await URLSession.shared.data(for: request)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            fatalError("Error: Can't fetching detail.")
        }
        
        let decoder = JSONDecoder()
        let result = try decoder.decode(GameDetailResponse.self, from: data)
        return gameDetailMapper(input: result)
    }
}

extension NetworkService {
    fileprivate func gameMapper(
        input gameResponses: [GameResponse]
    ) -> [Game] {
        return gameResponses.map { item in
            return Game(
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

extension NetworkService {
    fileprivate func gameDetailMapper(
        input: GameDetailResponse
    ) -> GameDetail {
        return GameDetail(
            alternativeNames: input.alternativeNames ?? [],
            backgroundImage: URL(string: input.backgroundImage ?? ""),
            description: input.descriptionRaw ?? "",
            developers: input.developers?.compactMap { $0.name } ?? [],
            esrbRating: input.esrbRating.map { $0.name ?? "" } ?? "",
            genres: input.genres?.compactMap { $0.name } ?? [],
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
