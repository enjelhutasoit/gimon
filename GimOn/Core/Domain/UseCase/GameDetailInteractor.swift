//
//  GameDetailInteractor.swift
//  GimOn
//
//  Created by Enjel Hutasoit on 26/08/25.
//

import Foundation

class GameDetailInteractor {
    private let repository: GameRepositoryProtocol
    
    init(repository: GameRepositoryProtocol) {
        self.repository = repository
    }
}

extension GameDetailInteractor: GameDetailUseCase {
    func getGameDetail(for id: Int, completion: @escaping (Result<GameDetailModel, any Error>) -> Void) {
        repository.getGameDetail(for: id) { result in
            completion(result)
        }
    }
}
