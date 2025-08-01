//
//  GameHighlightView.swift
//  GimOn
//
//  Created by Enjel Hutasoit on 01/08/25.
//

import SwiftUI

struct GameHighlightView: View {
    let title: String
    let genres: [String]?
    let rating: String?
    let ratingCount: String?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            VStack(alignment: .leading) {
                Text(title)
                    .font(.custom(AppFonts.extraBold, size: AppFontSizes.largeTitle))
                    .lineLimit(2)
            }
            .foregroundColor(AppColors.primaryTextColor)
            
            HStack(alignment: .top) {
                make(genres: genres ?? [])
                Spacer()
                make(rating: rating ?? "", ratingCount: ratingCount ?? "")
            }
        }
    }
    
    private func make(genres: [String]) -> some View {
        Group {
            let genreString = genres.joined(separator: " • ")
            Text(genreString)
                .font(.custom(AppFonts.regular, size: AppFontSizes.body))
                .foregroundStyle(AppColors.accentColor)
                .lineLimit(2)
        }
    }
    
    private func make(rating: String, ratingCount: String) -> some View {
        HStack(spacing: 2) {
            Image(systemName: "star")
                .font(.custom(AppFonts.regular, size: AppFontSizes.body))
                .foregroundStyle(AppColors.primaryColor)
            
            Text("\(rating) / \(ratingCount) reviews")
                .font(.custom(AppFonts.regular, size: AppFontSizes.body))
                .foregroundStyle(AppColors.accentColor)
        }
    }
}
