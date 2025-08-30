//
//  AppTabView.swift
//  GimOn
//
//  Created by Enjel Hutasoit on 31/07/25.
//

import SwiftUI

struct AppTabView: View {
    
    @EnvironmentObject var gameListPresenter: GameListPresenter
    @EnvironmentObject var favoritesListPresenter: FavoritesListPresenter
    @EnvironmentObject var profilePresenter: ProfilePresenter

    var body: some View {
        TabView {
            Group {
                NavigationStack {
                    GameListView(presenter: gameListPresenter)
                }
                .tabItem {
                    Label("Games", systemImage: "gamecontroller")
                }
                
                NavigationStack {
                    FavoriteListView(
                        presenter: favoritesListPresenter
                    )
                }
                .tabItem {
                    Label("Favorite", systemImage: "heart")
                }
                
                NavigationStack {
                    ProfileView(
                        presenter: profilePresenter
                    )
                }
                .tabItem {
                    Label("Profil", systemImage: "person.crop.circle.fill")
                }
            }
            .toolbarBackground(.black, for: .tabBar)
            .preferredColorScheme(.dark)
        }
    }
}
