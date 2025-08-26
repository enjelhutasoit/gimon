//
//  GameDetailView.swift
//  GimOn
//
//  Created by Enjel Hutasoit on 01/08/25.
//

import SwiftUI

struct GameDetailView: View {
    private let id: Int
    @State private var errorMessage: String?
    @State private var game: GameDetailModel?
    @State private var isDescriptionExpanded: Bool = false
    @State private var isFavorite: Bool = false
    @State private var isLoading: Bool = false
    @Environment(\.dismiss) private var dismiss
    
    @EnvironmentObject var coreDataManager: CoreDataManager
    
    init(id: Int) {
        self.id = id
    }
    
    var body: some View {
        GeometryReader { geoProxy in
            if isLoading {
                LoadingView()
            } else if let errorMessage {
                ErrorView(
                    message: errorMessage,
                    retryAction: {
                        Task { await getDetail(id: id) }
                    }
                )
            } else {
                loadedView(geoProxy: geoProxy)
                    .padding(.bottom, 21)
            }
        }
        .background(.black)
        .ignoresSafeArea(edges: .top)
        .toolbarBackground(.hidden, for: .navigationBar)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                BackArrowButton { dismiss() }
            }
        }
        .task {
            await getDetail(id: id)
        }
    }
}

extension GameDetailView {
    private func loadedView(geoProxy: GeometryProxy) -> some View {
        ScrollView {
            ZStack(alignment: .bottom) {
                posterView(geoProxy)
                highlighView
            }
            
            VStack(alignment: .leading, spacing: 21) {
                SharpEdgeDivider()
                favoriteButton
                metaDataView
                platformView
                descriptionView
                storeAndExploreMoreView
                developersAndAlternativeNamesView
                tagsView
            }
            .padding(.horizontal)
        }
    }
    
    private var favoriteButton: some View {
        FavoriteButton(isSelected: $isFavorite) {
            toggleFavorite()
        }
        .frame(maxWidth: .infinity, alignment: .center)
    }
    
    private func posterView(_ geoProxy: GeometryProxy) -> some View {
        GamePosterDetailView(
            posterURL: game?.backgroundImage,
            height: geoProxy.size.height / 2,
            width: geoProxy.size.width
        )
    }
    
    private var highlighView: some View {
        GameHighlightView(
            title: game?.name ?? "",
            genres: game?.genres ?? [],
            rating: game?.rating ?? "",
            ratingCount: game?.ratingCount ?? ""
        )
        .padding(.bottom)
        .padding(.horizontal)
    }

    private var metaDataView: some View {
        GameMetadataView(
            esrb: game?.esrbRating ?? "",
            metacritic: "\(game?.metacritic ?? 0)",
            playtime: game?.playtime ?? "",
            released: game?.released ?? ""
        )
    }
    
    private var platformView: some View {
        PlatformsDetailView(
            title: "Platforms",
            platforms: game?.parentPlatforms ?? []
        )
    }
    
    private var descriptionView: some View {
        DescriptionView(
            title: "Description",
            description: game?.description ?? "",
            isDescriptionExpanded: $isDescriptionExpanded
        )
    }
    
    private var storeAndExploreMoreView: some View {
        StoreAndExploreMore(
            stores: game?.stores ?? [],
            website: game?.website,
            reddit: game?.redditURL,
            metacritic: game?.metacriticURL
        )
    }
    
    private var developersAndAlternativeNamesView: some View {
        DevelopersAndAlternativeNamesView(
            developers: game?.developers ?? [],
            alternativeNames: game?.alternativeNames ?? []
        )
    }
    
    private var tagsView: some View {
        RowView("Tags", values: game?.tags ?? [])
    }

}

extension GameDetailView {
    private func getDetail(id: Int) async {
        isLoading = true
        defer { isLoading = false }
        
        let result = await NetworkService().getGame(id: id)
        switch result {
        case .success(let fetchedGame):
            await MainActor.run {
                self.game = fetchedGame
                self.isFavorite = coreDataManager.favoriteGames.contains { $0.id == fetchedGame.id }
                self.errorMessage = nil
            }
            
        case .failure(let error):
            await MainActor.run {
                self.errorMessage = error.description
            }
        }
    }
    
    private func toggleFavorite() {
        if isFavorite {
            if let game {
                coreDataManager.removeFavorite(game)
            }
        } else {
            if let game {
                coreDataManager.addFavorite(game)
            }
        }
        isFavorite.toggle()
    }
}
