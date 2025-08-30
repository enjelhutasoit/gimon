//
//  GameDetailPresenter.swift
//  GimOn
//
//  Created by Enjel Hutasoit on 26/08/25.
//

import Combine
import SwiftUI

class GameDetailPresenter: ObservableObject {
    private var cancellables: Set<AnyCancellable> = []
    private let useCase: GameDetailUseCase
    private let id: Int
    
    @Published var errorMessage: String = ""
    @Published var gameDetail: GameDetailModel?
    @Published var isLoading: Bool = false
    
    init(useCase: GameDetailUseCase, id: Int) {
        self.useCase = useCase
        self.id = id
    }
    
    func getGameDetail() {
        isLoading = true
        
        useCase.getGameDetail(for: id)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    self.isLoading = false
                case .failure(let error):
                    self.isLoading = false
                    self.errorMessage = error.localizedDescription
                }
            }, receiveValue: { gameDetailModel in
                self.gameDetail = gameDetailModel
            })
            .store(in: &cancellables)
    }
    
    func updateGame() {
        useCase
            .updateGameDetail(for: id)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    self.isLoading = false
                case .failure(let error):
                    self.isLoading = false
                    self.errorMessage = error.localizedDescription
                }
            }, receiveValue: { gameDetail in
                self.gameDetail = gameDetail
            })
            .store(in: &cancellables)
    }
}
