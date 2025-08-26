//
//  FavoritesListPresenter.swift
//  GimOn
//
//  Created by Enjel Hutasoit on 26/08/25.
//

import Combine
import SwiftUI

class FavoritesListPresenter: ObservableObject {
    
    private var cancellables: Set<AnyCancellable> = []
    private let useCase: FavoritesListUseCase
    let router: FavoritesListRouter = FavoritesListRouter()
    
    @Published var errorMessage: String = ""
    @Published var favoriteList: [GameModel] = []
    @Published var isLoading: Bool = false
    
    init(useCase: FavoritesListUseCase) {
        self.useCase = useCase
    }
    
    func getFavoriteList() {
        isLoading = false
        
        useCase.getFavoriteList()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    self.isLoading = false
                case .failure(let error):
                    self.isLoading = false
                    self.errorMessage = error.localizedDescription
                }
            }, receiveValue: { favList in
                self.favoriteList = favList
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
