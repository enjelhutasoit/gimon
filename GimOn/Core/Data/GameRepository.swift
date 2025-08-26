////
////  GameRepository.swift
////  GimOn
////
////  Created by Enjel Hutasoit on 26/08/25.
////

import Combine
import Foundation

protocol GameRepositoryProtocol {
    func getGameList() -> AnyPublisher<[GameModel], Error>
    func getGameDetail(for id: Int) -> AnyPublisher<GameDetailModel, Error>
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
    func getGameList() -> AnyPublisher<[GameModel], Error> {
        remote
            .getGameList()
            .map { GameMapper.gameMapper(input: $0) }
            .eraseToAnyPublisher()
    }
    
    func getGameDetail(for id: Int) -> AnyPublisher<GameDetailModel, Error> {
        remote
            .getGameDetail(for: id)
            .map { GameMapper.gameDetailMapper(input: $0) }
            .eraseToAnyPublisher()
    }
}
