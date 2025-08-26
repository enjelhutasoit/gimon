//
//  FavoritesListRouter.swift
//  GimOn
//
//  Created by Enjel Hutasoit on 26/08/25.
//

import SwiftUI

class FavoritesListRouter {
    func makeDetailView(for id: Int) -> some View {
        let interactor = Injection.init().provideGameDetailUseCase()
        let presenter = GameDetailPresenter(useCase: interactor, id: id)
        return GameDetailView(presenter: presenter)
    }
}
