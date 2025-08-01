//
//  PlatformsDetailView.swift
//  GimOn
//
//  Created by Enjel Hutasoit on 01/08/25.
//

import SwiftUI

struct PlatformsDetailView: View {
    let title: String
    let platforms: [PlatformModel]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.custom(AppFonts.semiBold, size: AppFontSizes.title3))
                .foregroundStyle(AppColors.primaryColor)
            
            ScrollView(.horizontal) {
                HStack(spacing: 12) {
                    ForEach(platforms, id: \.self) { platform in
                        platformView(for: platform.slug, name: platform.name)
                    }
                }
            }
        }
    }
    
    private func platformView(for slug: String, name: String) -> some View {
        VStack(alignment: .center, spacing: 2) {
            PlatformIconProvider.icon(for: slug)
                .foregroundStyle(AppColors.accentColor)
                .frame(maxWidth: .infinity)

            Text(name)
                .truncationMode(.tail)
                .foregroundStyle(AppColors.accentColor)
                .lineLimit(2)
                .multilineTextAlignment(.center)

        }
        .font(.custom(AppFonts.regular, size: AppFontSizes.body))
    }
}
