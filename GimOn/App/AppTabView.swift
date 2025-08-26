//
//  AppTabView.swift
//  GimOn
//
//  Created by Enjel Hutasoit on 31/07/25.
//

import SwiftUI

struct AppTabView: View {
    
    @EnvironmentObject var gameListPresenter: GameListPresenter

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
                    FavoritesListView()
                }
                .tabItem {
                    Label("Favorite", systemImage: "heart")
                }
                
                NavigationStack {
                    ProfileView()
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
