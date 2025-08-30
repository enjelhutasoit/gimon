//
//  GimOnApp.swift
//  GimOn
//
//  Created by Enjel Hutasoit on 31/07/25.
//

import SwiftUI

@main
struct GimOnApp: App {
    
    let gameListPresenter = GameListPresenter(
        useCase: Injection.init().provideGameListUseCase()
    )
    
    let favoritesListPresenter = FavoritesListPresenter(
        useCase: Injection.init().provideFavoritesListUseCase()
    )
    
    let profilePresenter = ProfilePresenter(
        useCase: Injection.init().provideProfileUseCase()
    )

    var body: some Scene {
        WindowGroup {
            AppTabView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .tint(AppColors.primaryColor)
                .environmentObject(gameListPresenter)
                .environmentObject(favoritesListPresenter)
                .environmentObject(profilePresenter)
        }
    }
}
