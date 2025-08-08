//
//  AppTabView.swift
//  GimOn
//
//  Created by Enjel Hutasoit on 31/07/25.
//

import SwiftUI

struct AppTabView: View {
    var body: some View {
        TabView {
            Group {
                NavigationStack {
                    GameListView()
                }
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
                
                NavigationStack {
                    SearchView()
                }
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
                
                NavigationStack {
                    ProfileView()
                }
                .tabItem {
                    Label("Profil", systemImage: "person.crop.circle.fill")
                        .tint(AppColors.primaryColor)
                }
            }
            .toolbarBackground(.black, for: .tabBar)
        }
    }
}
