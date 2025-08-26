//
//  GameDetailInteractor.swift
//  GimOn
//
//  Created by Enjel Hutasoit on 26/08/25.
//

import Combine

class GameDetailInteractor {
    private let repository: GameRepositoryProtocol
    
    init(repository: GameRepositoryProtocol) {
        self.repository = repository
    }
}

extension GameDetailInteractor: GameDetailUseCase {
    func getGameDetail(for id: Int) -> AnyPublisher<GameDetailModel, Error> {
        repository.getGameDetail(for: id)
    }
}
