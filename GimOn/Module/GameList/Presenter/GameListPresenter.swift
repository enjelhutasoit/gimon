//
//  GameListPresenter.swift
//  GimOn
//
//  Created by Enjel Hutasoit on 26/08/25.
//

import SwiftUI

class GameListPresenter: ObservableObject {
    private let useCase: GameListUseCase
    
    @Published var gameList: [GameModel] = []
    @Published var errorMessage: String = ""
    @Published var isLoading: Bool = false
    
    init(useCase: GameListUseCase) {
        self.useCase = useCase
    }
    
    func getGameList() {
        guard gameList.isEmpty else { return }

        isLoading = true
        
        useCase.getGameList { result in
            switch result {
            case .success(let gameList):
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.gameList = gameList
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    func linkBuilder<Content: View>(for id: Int, @ViewBuilder content: () -> Content) -> some View {
        NavigationLink(
            destination: GameDetailView(id: id)
        ) {
            content()
        }
        .buttonStyle(.plain)
    }
}
