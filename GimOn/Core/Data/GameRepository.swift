////
////  GameRepository.swift
////  GimOn
////
////  Created by Enjel Hutasoit on 26/08/25.
////

import Foundation

protocol GameRepositoryProtocol {
    func getGameList(result: @escaping (Result<[GameModel], Error>) -> Void)
    func getGameDetail(for id: Int, result: @escaping (Result<GameDetailModel, Error>) -> Void)
}

final class GameRepository: NSObject {
    typealias GameInstance = (GameRemoteDataSource) -> GameRepository
    
    private let remote: GameRemoteDataSource
    
    static let sharedInstance: GameInstance = { remoteRepo in
        GameRepository(remote: remoteRepo)
    }
    
    init(remote: GameRemoteDataSource) {
        self.remote = remote
    }
}

extension GameRepository: GameRepositoryProtocol {
    func getGameList(result: @escaping (Result<[GameModel], Error>) -> Void) {
        remote.getGameList { remoteResponse in
            switch remoteResponse {
            case .success(let gameListResponse):
                let gameListModel = GameMapper.gameMapper(input: gameListResponse)
                result(.success(gameListModel))
            case .failure(let error):
                result(.failure(error))
            }
        }
    }
    
    func getGameDetail(for id: Int, result: @escaping (Result<GameDetailModel, any Error>) -> Void) {
        remote.getGameDetail(for: id) { remoteResponse in
            switch remoteResponse {
            case .success(let gameDetailResponse):
                let gameDetailModel = GameMapper.gameDetailMapper(input: gameDetailResponse)
                result(.success(gameDetailModel))
            case .failure(let error):
                result(.failure(error))
            }
        }
    }
}
