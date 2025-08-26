////
////  GameRemoteDataSource.swift
////  GimOn
////
////  Created by Enjel Hutasoit on 26/08/25.
////

import Foundation
import Alamofire

protocol GameRemoteDataSourceProtocol {
    func getGameList(result: @escaping (Result<[GameResponse], Error>) -> Void)
    func getGameDetail(for id: Int, result: @escaping (Result<GameDetailResponse, Error>) -> Void)
}

final class GameRemoteDataSource: NSObject {
    static let sharedInstance = GameRemoteDataSource()
    private override init() { }
}

extension GameRemoteDataSource: GameRemoteDataSourceProtocol {
    func getGameList(result: @escaping (Result<[GameResponse], Error>) -> Void) {
        if let url = URL(string: EndPoints.Gets.gameList.url) {
            AF
                .request(url)
                .validate()
                .responseDecodable(of: GameListResponse.self) { response in
                    switch response.result {
                    case .success(let gameListResponse):
                        result(.success(gameListResponse.games))
                    case .failure:
                        result(.failure(NetworkError.invalidResponse))
                    }
                }
        }
    }
    
    func getGameDetail(for id: Int, result: @escaping (Result<GameDetailResponse, Error>) -> Void) {
        if let url = URL(string: EndPoints.Gets.gameDetail(id: id).url) {
            AF
                .request(url)
                .validate()
                .responseDecodable(of: GameDetailResponse.self) { response in
                    switch response.result {
                    case .success(let gameDetailResponse):
                        result(.success(gameDetailResponse))
                    case .failure:
                        result(.failure(NetworkError.invalidResponse))
                    }
                }
        }
    }
}
