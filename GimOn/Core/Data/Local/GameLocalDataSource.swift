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
}

final class GameLocalDataSource: NSObject {
    
    private let realm: Realm?
    
    static let sharedInstance: (Realm?) -> GameLocalDataSource = { realmDataBase in
        return GameLocalDataSource(realm: realmDataBase)
    }
    
    init(realm: Realm?) {
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
