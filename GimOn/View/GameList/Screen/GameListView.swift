//
//  GameListView.swift
//  GimOn
//
//  Created by Enjel Hutasoit on 31/07/25.
//

import SwiftUI

struct GameListView: View {
    private let itemHeight = 135.0
    private let itemWidth = 143.0
    @State private var errorMessage: String?
    @State private var games: [Game] = []
    @State private var isLoading: Bool = false
    @State private var selectedItem: Game?

    var body: some View {
        NavigationStack {
            VStack(spacing: 12) {
                LogoView()
                
                if isLoading {
                    LoadingView()
                } else if let errorMessage {
                    ErrorView(
                        message: errorMessage,
                        retryAction: {
                            Task { await getListGame() }
                        }
                    )
                } else {
                    loadedView
                }
            }
            .background(.black)
            .navigationDestination(item: $selectedItem) { game in
                GameDetailView(id: game.id)
            }
            .task {
                await getListGame()
            }
        }
    }
}

extension GameListView {
    private var loadedView: some View {
        ScrollView {
            LazyVStack {
                ForEach(games) { game in
                    GameItemView(
                        game: game,
                        posterSize: CGSize(width: itemWidth, height: itemHeight)
                    ) {
                        selectedItem = game
                    }
                    .padding(.top, 18)
                    .padding(.horizontal, 2)
                }
            }
        }
    }
}

extension GameListView {
    private func getListGame() async {
        isLoading = true
        errorMessage = nil
        let networkService = NetworkService()
        let result = await networkService.getGames()
        
        switch result {
        case .success(let fetchesGames):
            games = fetchesGames
            errorMessage = nil
        case .failure(let error):
            errorMessage = error.description
        }
        
        isLoading = false
    }
}
