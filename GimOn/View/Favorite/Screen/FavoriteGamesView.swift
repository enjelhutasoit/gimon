//
//  FavoriteGamesView.swift
//  GimOn
//
//  Created by Enjel Hutasoit on 08/08/25.
//

import SwiftUI

struct FavoritesGameView: View {
    private let itemHeight = 135.0
    private let itemWidth = 143.0
    @State private var errorMessage: String?
    @State private var games: [Game] = []
    @State private var isLoading: Bool = false
    @State private var selectedItem: Game?

    var body: some View {
        Group {
            if let errorMessage {
                ErrorView(
                    message: errorMessage,
                    retryAction: {
                        Task { await getListGame() }
                    }
                )
            } else {
                if games.count > 0 {
                    loadedView
                } else {
                    EmptyListView(message: "Your favorites list is empty.")
                }
            }
        }
        .background(.black)
        .navigationDestination(item: $selectedItem) { game in
            GameDetailView(id: game.id)
        }
        .task {
            await getListGame()
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Favorites")
                    .font(.custom(AppFonts.extraBold, size: AppFontSizes.title2))
                    .foregroundStyle(AppColors.primaryColor)
            }
        }
        .toolbarBackground(.black, for: .navigationBar)
        .navigationBarTitleDisplayMode(.inline)
    }
}

extension FavoritesGameView {
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

extension FavoritesGameView {
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
