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
    
    @ObservedObject var presenter: GameListPresenter
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 12) {
                LogoView()
                
                if presenter.isLoading {
                    LoadingView()
                } else if !presenter.errorMessage.isEmpty {
                    ErrorView(
                        message: presenter.errorMessage,
                        retryAction: { presenter.getGameList() }
                    )
                } else {
                    loadedView
                }
            }
            .background(.black)
            .onAppear {
                presenter.getGameList()
            }
        }
    }
}

extension GameListView {
    private var loadedView: some View {
        ScrollView {
            LazyVStack {
                ForEach(presenter.gameList) { game in
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
