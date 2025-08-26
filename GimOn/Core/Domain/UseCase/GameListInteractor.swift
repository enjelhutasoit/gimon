//
//  GameListInteractor.swift
//  GimOn
//
//  Created by Enjel Hutasoit on 26/08/25.
//

import Combine

class GameListInteractor {
    
    private let reposisitory: GameRepositoryProtocol
    
    init(repository: GameRepositoryProtocol) {
        self.reposisitory = repository
    }
}

extension GameListInteractor: GameListUseCase {
    func getGameList() -> AnyPublisher<[GameModel], Error> {
        reposisitory.getGameList()
    }
}
