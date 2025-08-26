//
//  GimOnApp.swift
//  GimOn
//
//  Created by Enjel Hutasoit on 31/07/25.
//

import SwiftUI

@main
struct GimOnApp: App {
    
    @StateObject private var coreDataManager = CoreDataManager()

    let gameListPresenter = GameListPresenter(
        useCase: Injection.init().provideGameListUseCase()
    )

    var body: some Scene {
        WindowGroup {
            AppTabView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .tint(AppColors.primaryColor)
                .environmentObject(coreDataManager)
                .environmentObject(gameListPresenter)
        }
    }
}
