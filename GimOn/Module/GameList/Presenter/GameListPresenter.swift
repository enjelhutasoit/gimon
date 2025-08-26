//
//  GameListPresenter.swift
//  GimOn
//
//  Created by Enjel Hutasoit on 26/08/25.
//

import Combine
import SwiftUI

class GameListPresenter: ObservableObject {
    private var cancellables: Set<AnyCancellable> = []
    private let useCase: GameListUseCase
    
    @Published var gameList: [GameModel] = []
    @Published var errorMessage: String = ""
    @Published var isLoading: Bool = false
    let router = GameListRouter()
    
    init(useCase: GameListUseCase) {
        self.useCase = useCase
    }
    
    func getGameList() {
        guard gameList.isEmpty else { return }
        
        isLoading = true
        
        useCase.getGameList()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    self.isLoading = false
                case .failure(let error):
                    self.isLoading = false
                    self.errorMessage = error.localizedDescription
                }
                
            }, receiveValue: { gameListModel in
                self.gameList = gameListModel
            })
            .store(in: &cancellables)
    }
    
    func linkBuilder<Content: View>(for id: Int, @ViewBuilder content: () -> Content) -> some View {
        NavigationLink(
            destination: router.makeDetailView(for: id)
        ) {
            content()
        }
        .buttonStyle(.plain)
    }
}
