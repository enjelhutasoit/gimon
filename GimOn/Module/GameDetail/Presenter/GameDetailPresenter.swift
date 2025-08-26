//
//  GameDetailPresenter.swift
//  GimOn
//
//  Created by Enjel Hutasoit on 26/08/25.
//

import SwiftUI

class GameDetailPresenter: ObservableObject {
    
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
        
        useCase.getGameDetail(for: id) { result in
            switch result {
            case .success(let gameDetail):
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.gameDetail = gameDetail
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
