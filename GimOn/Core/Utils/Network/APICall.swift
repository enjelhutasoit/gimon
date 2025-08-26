//
//  APICall.swift
//  GimOn
//
//  Created by Enjel Hutasoit on 26/08/25.
//

import Foundation

struct API {
    static let baseUrl = "https://api.rawg.io/api/games"
    
    static let apiKey: String = {
        guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String else {
            fatalError("API_KEY not found in Info.plist")
        }
        return apiKey
    }()
}

protocol Endpoint {
    var url: String { get }
}

enum EndPoints {
    enum Gets: Endpoint {
        case gameList
        case gameDetail(id: Int)
        
        var url: String {
            switch self {
            case .gameList:
                "\(API.baseUrl)?key=\(API.apiKey)"
            case .gameDetail(let gameId):
                "\(API.baseUrl)/\(gameId)?key=\(API.apiKey)"
            }
        }
    }
}
