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
    func getFavoriteList() -> AnyPublisher<[GameModel], Error>
    func updateFavoriteDetail(for id: Int) -> AnyPublisher<GameDetailModel, Error>
}

final class GameRepository: NSObject {
    typealias GameInstance = (GameLocalDataSource, GameRemoteDataSource) -> GameRepository
    
    private let local: GameLocalDataSource
    private let remote: GameRemoteDataSource
    
    static let sharedInstance: GameInstance = { localRepo, remoteRepo in
        GameRepository(local: localRepo, remote: remoteRepo)
    }
    
    init(local: GameLocalDataSource, remote: GameRemoteDataSource) {
        self.local = local
        self.remote = remote
    }
}

extension GameRepository: GameRepositoryProtocol {
    func getGameList() -> AnyPublisher<[GameModel], Error> {
        local
            .getGameList()
            .flatMap { result -> AnyPublisher<[GameModel], Error> in
                if result.isEmpty {
                    return self.remote
                        .getGameList()
                        .map { GameMapper.mapGameResponsesToEntities($0) }
                        .catch { _ in self.local.getGameList() }
                        .flatMap { games in
                            self.local.addGameList(games)
                        }
                        .filter { $0 }
                        .flatMap { _ in
                            self.local.getGameList()
                                .map { GameMapper.mapGameEntitiesToDomainModels($0) }
                        }
                        .eraseToAnyPublisher()
                } else {
                    return self.local
                        .getGameList()
                        .map { GameMapper.mapGameEntitiesToDomainModels($0) }
                        .eraseToAnyPublisher()
                }
            }
            .eraseToAnyPublisher()
    }
    
    func getGameDetail(for id: Int) -> AnyPublisher<GameDetailModel, Error> {
        local
            .getGameDetail(for: id)
            .tryCatch { _ -> AnyPublisher<GameDetailEntity, Error> in
                return self.remote.getGameDetail(for: id)
                    .map { GameMapper.mapGameDetailResponseToEntity($0) }
                    .flatMap { entity in
                        self.local.addGame(entity)
                            .filter { $0 }
                            .map { _ in entity }
                    }
                    .eraseToAnyPublisher()
            }
            .map { GameMapper.mapGameDetailEntityToDomainModel($0) }
            .eraseToAnyPublisher()
    }
    
    func getFavoriteList() -> AnyPublisher<[GameModel], Error> {
        local
            .getFavoriteList()
            .map { GameMapper.mapGameEntitiesToDomainModels($0)  }
            .eraseToAnyPublisher()
    }
    
    func updateFavoriteDetail(for id: Int) -> AnyPublisher<GameDetailModel, Error> {
        local
            .updateFavorite(of: id)
            .map { GameMapper.mapGameDetailEntityToDomainModel($0) }
            .eraseToAnyPublisher()
    }
}
