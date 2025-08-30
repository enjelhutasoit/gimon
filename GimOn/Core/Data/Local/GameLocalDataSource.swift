//
//  GameLocalDataSource.swift
//  GimOn
//
//  Created by Enjel Hutasoit on 26/08/25.
//

import Combine
import Foundation
import RealmSwift

protocol GameLocalDataSourceProtocol: AnyObject {
    func getGameList() -> AnyPublisher<[GameEntity], Error>
    func getGameDetail(for id: Int) -> AnyPublisher<GameDetailEntity, Error>
    func addGameList(_ games: [GameEntity]) -> AnyPublisher<Bool, Error>
    func addGame(_ game: GameDetailEntity) -> AnyPublisher<Bool, Error>
    func getFavoriteList() -> AnyPublisher<[GameEntity], Error>
    func updateFavorite(of id: Int) -> AnyPublisher<GameDetailEntity, Error>
}

final class GameLocalDataSource: NSObject {
    
    private let realm: Realm?
    
    static let sharedInstance: (Realm?) -> GameLocalDataSource = { realmDatabase in
        return GameLocalDataSource(realm: realmDatabase)
    }
    
    private init(realm: Realm?) {
        self.realm = realm
    }
}

extension GameLocalDataSource: GameLocalDataSourceProtocol {
    func getGameList() -> AnyPublisher<[GameEntity], Error> {
        Future<[GameEntity], Error> { completion in
            if let realm = self.realm {
                let games: Results<GameEntity> = {
                    realm.objects(GameEntity.self)
                }()
                completion(.success(games.toArray(ofType: GameEntity.self)))
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }
        .eraseToAnyPublisher()
    }
    
    func addGameList(_ games: [GameEntity]) -> AnyPublisher<Bool, Error> {
        Future<Bool, Error> { completion in
            if let realm = self.realm {
                do {
                    try realm.write {
                        for game in games {
                            realm.add(game, update: .all)
                        }
                        completion(.success(true))
                    }
                } catch {
                    completion(.failure(DatabaseError.requestFailed))
                }
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    func getGameDetail(for id: Int) -> AnyPublisher<GameDetailEntity, Error> {
        Future<GameDetailEntity, Error> { completion in
            if let realm = self.realm {
                let game = realm.objects(GameDetailEntity.self)
                    .filter("id == %d", id)
                    .first
                
                if let game {
                    completion(.success(game))
                } else {
                    completion(.failure(DatabaseError.requestFailed))
                }
                
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }
        .eraseToAnyPublisher()
    }
    
    func addGame(_ game: GameDetailEntity) -> AnyPublisher<Bool, Error> {
        Future<Bool, Error> { completion in
            if let realm = self.realm {
                do {
                    try realm.write {
                        realm.add(game, update: .all)
                        completion(.success(true))
                    }
                } catch {
                    completion(.failure(DatabaseError.requestFailed))
                }
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }
        .eraseToAnyPublisher()
    }
    
    func getFavoriteList() -> AnyPublisher<[GameEntity], any Error> {
        return Future<[GameEntity], Error> { completion in
            if let realm = self.realm {
                
                let favoriteEntity = {
                    let sample = realm.objects(GameEntity.self)
                        .filter("favorite == true")
                    return sample
                }()
                
                completion(.success(favoriteEntity.toArray(ofType: GameEntity.self)))
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }
        .eraseToAnyPublisher()
    }
    
    func updateFavorite(of id: Int) -> AnyPublisher<GameDetailEntity, Error> {
        return Future<GameDetailEntity, Error> { completion in
            guard let realm = self.realm else {
                completion(.failure(DatabaseError.invalidInstance))
                return
            }
            
            guard let gameDetailEntity = realm.object(ofType: GameDetailEntity.self, forPrimaryKey: id) else {
                completion(.failure(DatabaseError.requestFailed))
                return
            }
            
            do {
                try realm.write {
                    gameDetailEntity.favorite.toggle()
                    
                    /// Sync GameEntity.favorite if exists
                    if let gameListEntity = realm.object(ofType: GameEntity.self, forPrimaryKey: id) {
                        gameListEntity.favorite = gameDetailEntity.favorite
                    }
                }
                completion(.success(gameDetailEntity))
            } catch {
                completion(.failure(DatabaseError.requestFailed))
            }
        }
        .eraseToAnyPublisher()
    }
}

extension Results {
    func toArray<T>(ofType: T.Type) -> [T] {
        var array = [T]()
        for index in 0 ..< count {
            if let result = self[index] as? T {
                array.append(result)
            }
        }
        return array
    }
}
