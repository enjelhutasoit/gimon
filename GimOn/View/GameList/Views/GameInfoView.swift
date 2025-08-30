//
//  GameInfoView.swift
//  GimOn
//
//  Created by Enjel Hutasoit on 31/07/25.
//

import SwiftUI

struct GameInfoView: View {
    let game: Game
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(game.name)
                .font(.custom(AppFonts.semiBold,
                        size: AppFontSizes.title3))
                .lineLimit(2)
                .foregroundStyle(AppColors.primaryTextColor)
            
            HStack(spacing: 2) {
                Image(systemName: "star")
                    .font(.custom(AppFonts.extraLight, size: AppFontSizes.caption))
                    .foregroundStyle(AppColors.primaryColor)
                
                Text("\(game.rating) / \(game.ratingCount) reviews")
                    .lineLimit(1)
                    .font(.custom(AppFonts.regular,
                            size: AppFontSizes.body))
                    .foregroundStyle(AppColors.primaryTextColor)
            }
            
            make(year: game.released, playtime: game.playtime)
            make(genres: game.genres)
            make(platforms: game.parentPlatforms)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

extension GameInfoView {
    func make(year: String, playtime: String) -> some View {
        HStack(spacing: 18) {
            Label(year, systemImage: "calendar")
            Label(playtime, systemImage: "clock")
        }
        .font(.custom(AppFonts.regular, size: AppFontSizes.body))
        .foregroundStyle(AppColors.accentColor)
    }
    
    func make(platforms: [String]) -> some View {
        HStack {
            ForEach(platforms.prefix(6), id: \.self) { platform in
                PlatformIconProvider.icon(for: platform)
                    .font(.custom(AppFonts.regular, size: AppFontSizes.body))
                    .foregroundStyle(AppColors.primaryColor)
            }
        }
    }
    
    func make(genres: [String]) -> some View {
        HStack(alignment: .center) {
            ForEach(Array(genres.prefix(3).enumerated()), id: \.element) { index, genre in
                Text(genre)
                    .font(.custom(AppFonts.regular, size: AppFontSizes.body))
                    .foregroundStyle(AppColors.accentColor)
                    .lineLimit(1)
                
                if index < genres.prefix(3).count - 1 {
                    Circle()
                        .frame(width: 6, height: 6)
                        .foregroundStyle(AppColors.accentColor)
                }
            }
        }
    }
}
