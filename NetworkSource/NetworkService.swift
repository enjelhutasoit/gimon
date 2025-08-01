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
