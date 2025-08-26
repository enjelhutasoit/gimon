//
//  GameListInteractor.swift
//  GimOn
//
//  Created by Enjel Hutasoit on 26/08/25.
//

import Foundation

protocol GameListUseCase {
    func getGameList(completion: @escaping (Result<[GameModel], Error>) -> Void)
}

class GameListInteractor {
    
    private let reposisitory: GameRepositoryProtocol
    
    init(repository: GameRepositoryProtocol) {
        self.reposisitory = repository
    }
}

extension GameListInteractor: GameListUseCase {
    func getGameList(completion: @escaping (Result<[GameModel], any Error>) -> Void) {
        reposisitory.getGameList { result in
            completion(result)
        }
    }
}
