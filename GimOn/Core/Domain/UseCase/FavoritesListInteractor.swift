//
//  FavoritesListInteractor.swift
//  GimOn
//
//  Created by Enjel Hutasoit on 26/08/25.
//

import Combine

class FavoritesListInteractor {
    
    private let repository: GameRepositoryProtocol
    
    required init(repository: GameRepositoryProtocol) {
        self.repository = repository
    }
}

extension FavoritesListInteractor: FavoritesListUseCase {
    func getFavoriteList() -> AnyPublisher<[GameModel], any Error> {
        repository.getFavoriteList()
    }
}
