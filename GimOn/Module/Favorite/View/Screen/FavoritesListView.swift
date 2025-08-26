//
//  FavoritesListView.swift
//  GimOn
//
//  Created by Enjel Hutasoit on 08/08/25.
//

import SwiftUI

struct FavoriteListView: View {
    
    private let itemHeight = 135.0
    private let itemWidth = 143.0
    
    @ObservedObject var presenter: FavoritesListPresenter
    
    var body: some View {
        Group {
            if presenter.isLoading {
                LoadingView()
            } else if !presenter.errorMessage.isEmpty {
                ErrorView(
                    message: presenter.errorMessage,
                    retryAction: { getFavoriteList() }
                )
            } else {
                if presenter.favoriteList.count > 0 {
                    loadedView
                } else {
                    EmptyListView(message: "Your favorites list is empty.")
                }
            }
        }
        .background(.black)
        .onAppear {
            getFavoriteList()
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

extension FavoriteListView {
    private func getFavoriteList() {
        presenter.getFavoriteList()
    }
    
    private var loadedView: some View {
        ScrollView {
            LazyVStack {
                ForEach(presenter.favoriteList) { game in
                    presenter.linkBuilder(for: game.id) {
                        GameItemView(
                            game: game,
                            posterSize: CGSize(width: itemWidth, height: itemHeight)
                        )
                    }
                    .padding(.top, 18)
                    .padding(.horizontal, 2)
                }
            }
        }
    }
}
