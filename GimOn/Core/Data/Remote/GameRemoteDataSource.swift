////
////  GameRemoteDataSource.swift
////  GimOn
////
////  Created by Enjel Hutasoit on 26/08/25.
////

import Alamofire
import Combine
import Foundation

protocol GameRemoteDataSourceProtocol {
    func getGameList() -> AnyPublisher<[GameResponse], Error>
    func getGameDetail(for id: Int) -> AnyPublisher<GameDetailResponse, Error>
}

final class GameRemoteDataSource: NSObject {
    static let sharedInstance = GameRemoteDataSource()
    private override init() { }
}

extension GameRemoteDataSource: GameRemoteDataSourceProtocol {
    func getGameList() -> AnyPublisher<[GameResponse], Error> {
        Future<[GameResponse], Error> { completion in
            if let url = URL(string: EndPoints.Gets.gameList.url) {
                AF
                    .request(url)
                    .validate()
                    .responseDecodable(of: GameListResponse.self) { response in
                        switch response.result {
                        case .success(let gameListResponse):
                            completion(.success(gameListResponse.games))
                        case .failure:
                            completion(.failure(NetworkError.invalidResponse))
                        }
                    }
            }
        }
        .eraseToAnyPublisher()
    }
    
    func getGameDetail(for id: Int) -> AnyPublisher<GameDetailResponse, Error> {
        Future<GameDetailResponse, Error> { completion in
            if let url = URL(string: EndPoints.Gets.gameDetail(id: id).url) {
                AF
                    .request(url)
                    .validate()
                    .responseDecodable(of: GameDetailResponse.self) { response in
                        switch response.result {
                        case .success(let gameDetailResponse):
                            completion(.success(gameDetailResponse))
                        case .failure:
                            completion(.failure(NetworkError.invalidResponse))
                        }
                    }
            }
        }
        .eraseToAnyPublisher()
    }
}
