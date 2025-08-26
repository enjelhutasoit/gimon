//
//  Injection.swift
//  GimOn
//
//  Created by Enjel Hutasoit on 26/08/25.
//

import Foundation

final class Injection: NSObject {
    
    private func provideRepository() -> GameRepositoryProtocol {
        let remote = GameRemoteDataSource.sharedInstance
        return GameRepository(remote: remote)
    }
    
    func provideGameListUseCase() -> GameListUseCase {
        GameListInteractor(repository: provideRepository())
    }
    
    func provideGameDetailUseCase() -> GameDetailUseCase {
        let repository = provideRepository()
        return GameDetailInteractor(repository: repository)
    }
}
