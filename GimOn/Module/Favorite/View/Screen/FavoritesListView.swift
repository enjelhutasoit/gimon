//
//  FavoritesListView.swift
//  GimOn
//
//  Created by Enjel Hutasoit on 08/08/25.
//

import SwiftUI

struct FavoritesListView: View {
    private let itemHeight = 135.0
    private let itemWidth = 143.0
    @State private var errorMessage: String?
    @State private var games: [GameModel] = []
    @State private var selectedItem: GameModel?
    
    var body: some View {
        Group {
            if let errorMessage {
                ErrorView(
                    message: errorMessage,
                    retryAction: { getListGame() }
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
//            GameDetailView(id: game.id)
        }
        .onAppear {
            getListGame()
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

extension FavoritesListView {
    private var loadedView: some View {
        ScrollView {
            LazyVStack {
                ForEach(games) { game in
                    GameItemView(
                        game: game,
                        posterSize: CGSize(width: itemWidth, height: itemHeight)
                    )
                    .padding(.top, 18)
                    .padding(.horizontal, 2)
                }
            }
        }
    }
}

extension FavoritesListView {
    private func getListGame() {
    }
}
