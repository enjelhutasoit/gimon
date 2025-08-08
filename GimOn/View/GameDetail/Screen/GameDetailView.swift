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
    @State private var game: GameDetail?
    @State private var isDescriptionExpanded: Bool = false
    @State private var isFavorite: Bool = false
    @State private var isLoading: Bool = false
    @Environment(\.dismiss) private var dismiss
    
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
            ToolbarItem(placement: .navigationBarLeading) {
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
                GamePosterDetailView(
                    posterURL: game?.backgroundImage,
                    height: geoProxy.size.height / 2,
                    width: geoProxy.size.width
                )
                
                GameHighlightView(
                    title: game?.name ?? "",
                    genres: game?.genres ?? [],
                    rating: game?.rating ?? "",
                    ratingCount: game?.ratingCount ?? ""
                )
                .padding(.bottom)
                .padding(.horizontal)
            }
            
            VStack(alignment: .leading, spacing: 21) {
                SharpEdgeDivider()
                
                favoriteButton
                
                GameMetadataView(
                    esrb: game?.esrbRating ?? "",
                    metacritic: "\(game?.metacritic ?? 0)",
                    playtime: game?.playtime ?? "",
                    released: game?.released ?? ""
                )
                
                PlatformsDetailView(
                    title: "Platforms",
                    platforms: game?.parentPlatforms ?? []
                )
                
                DescriptionView(
                    title: "Description",
                    description: game?.description ?? "",
                    isDescriptionExpanded: $isDescriptionExpanded
                )
                
                StoreAndExploreMore(
                    stores: game?.stores ?? [],
                    website: game?.website,
                    reddit: game?.redditURL,
                    metacritic: game?.metacriticURL
                )
                
                DevelopersAndAlternativeNamesView(
                    developers: game?.developers ?? [],
                    alternativeNames: game?.alternativeNames ?? []
                )
                
                RowView("Tags", values: game?.tags ?? [])
            }
            .padding(.horizontal)
        }
    }
    
    private var favoriteButton: some View {
        FavoriteButton(isSelected: $isFavorite) {
            isFavorite.toggle()
        }
        .frame(maxWidth: .infinity, alignment: .center)
    }
}

extension GameDetailView {
    private func getDetail(id: Int) async {
        isLoading = true
        let networkService = NetworkService()
        let result = await networkService.getGame(id: id)
        
        switch result {
        case .success(let fetchedGame):
            game = fetchedGame
            errorMessage = nil
        case .failure(let error):
            errorMessage = error.description
        }
        
        isLoading = false
    }
}
