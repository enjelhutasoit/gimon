//
//  GameDetailView.swift
//  GimOn
//
//  Created by Enjel Hutasoit on 01/08/25.
//

import SwiftUI

struct GameDetailView: View {
    
    @State private var isDescriptionExpanded: Bool = false
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var presenter: GameDetailPresenter
    
    var body: some View {
        GeometryReader { geoProxy in
            if presenter.isLoading {
                LoadingView()
            } else if !presenter.errorMessage.isEmpty {
                ErrorView(
                    message: presenter.errorMessage,
                    retryAction: {
                        getGameDetail()
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
        .onAppear {
            getGameDetail()
        }
    }
}

extension GameDetailView {
    private func getGameDetail() {
        presenter.getGameDetail()
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
        FavoriteButton(
            isSelected: presenter.gameDetail?.favorite ?? false
        ) {
            presenter.updateGame()
        }
        .frame(maxWidth: .infinity, alignment: .center)
    }
    
    private func posterView(_ geoProxy: GeometryProxy) -> some View {
        GamePosterDetailView(
            posterURL: presenter.gameDetail?.backgroundImage,
            height: geoProxy.size.height / 2,
            width: geoProxy.size.width
        )
    }
    
    private var highlighView: some View {
        GameHighlightView(
            title: presenter.gameDetail?.name ?? "",
            genres: presenter.gameDetail?.genres ?? [],
            rating: presenter.gameDetail?.rating ?? "",
            ratingCount: presenter.gameDetail?.ratingCount ?? ""
        )
        .padding(.bottom)
        .padding(.horizontal)
    }

    private var metaDataView: some View {
        GameMetadataView(
            esrb: presenter.gameDetail?.esrbRating ?? "",
            metacritic: "\(presenter.gameDetail?.metacritic ?? 0)",
            playtime: presenter.gameDetail?.playtime ?? "",
            released: presenter.gameDetail?.released ?? ""
        )
    }
    
    private var platformView: some View {
        PlatformsDetailView(
            title: "Platforms",
            platforms: presenter.gameDetail?.parentPlatforms ?? []
        )
    }
    
    private var descriptionView: some View {
        DescriptionView(
            title: "Description",
            description: presenter.gameDetail?.description ?? "",
            isDescriptionExpanded: $isDescriptionExpanded
        )
    }
    
    private var storeAndExploreMoreView: some View {
        StoreAndExploreMore(
            stores: presenter.gameDetail?.stores ?? [],
            website: presenter.gameDetail?.website,
            reddit: presenter.gameDetail?.redditURL,
            metacritic: presenter.gameDetail?.metacriticURL
        )
    }
    
    private var developersAndAlternativeNamesView: some View {
        DevelopersAndAlternativeNamesView(
            developers: presenter.gameDetail?.developers ?? [],
            alternativeNames: presenter.gameDetail?.alternativeNames ?? []
        )
    }
    
    private var tagsView: some View {
        RowView("Tags", values: presenter.gameDetail?.tags ?? [])
    }

}
