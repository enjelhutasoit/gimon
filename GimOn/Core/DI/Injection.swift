//
//  Injection.swift
//  GimOn
//
//  Created by Enjel Hutasoit on 26/08/25.
//

import Foundation
import RealmSwift

final class Injection: NSObject {
    
    private func provideRepository() -> GameRepositoryProtocol {
        let realm = try? Realm()
        let local = GameLocalDataSource.sharedInstance(realm)
        let remote = GameRemoteDataSource.sharedInstance
        return GameRepository(local: local, remote: remote)
    }
    
    func provideGameListUseCase() -> GameListUseCase {
        GameListInteractor(repository: provideRepository())
    }
    
    func provideGameDetailUseCase() -> GameDetailUseCase {
        let repository = provideRepository()
        return GameDetailInteractor(repository: repository)
    }
    
    func provideFavoritesListUseCase() -> FavoritesListUseCase {
        let repository = provideRepository()
        return FavoritesListInteractor(repository: repository)
    }
    
    func provideProfileRespository() -> ProfileRespositoryProtocol {
        let local = ProfileLocalDataSource(userDefault: UserDefaults.standard)
        return ProfileRespository(local: local)
    }
    
    func provideProfileUseCase() -> ProfileUseCase {
        let reposiroty = provideProfileRespository()
        return ProfileInteractor(repository: reposiroty)
    }
}
