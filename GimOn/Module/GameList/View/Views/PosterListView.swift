//
//  PosterListView.swift
//  GimOn
//
//  Created by Enjel Hutasoit on 31/07/25.
//

import CachedAsyncImage
import SwiftUI

struct PosterListView: View {
    private let posterURL: URL
    private let width: CGFloat
    private let height: CGFloat
    
    init(
        posterURL: URL,
        width: CGFloat,
        height: CGFloat
    ) {
        self.posterURL = posterURL
        self.width = width
        self.height = height
    }
    
    var body: some View {
        CachedAsyncImage(url: posterURL) { phase in
            switch phase {
            case .success(let image):
                loadedView(with: image)
            case .failure:
                errorView
            default:
                loadingView
            }
        }
        .frame(width: width, height: height)
    }
}

extension PosterListView {
    private func loadedView(with image: Image) -> some View {
        image
            .resizable()
            .scaledToFill()
            .frame(width: width, height: height)
            .clipped()
            .cornerRadius(8)
            .shadow(
                color: AppColors.primaryColor,
                radius: 2,
                x: 0,
                y: 0
            )
    }
    
    private var loadingView: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .stroke(AppColors.primaryColor, lineWidth: 1)
                .shadow(
                    color: AppColors.primaryColor.opacity(0.3),
                    radius: 2,
                    x: 0,
                    y: 0
                )
            ProgressView()
        }
    }
    
    private var errorView: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(.clear)
                .stroke(AppColors.primaryColor, lineWidth: 0.5)
                .shadow(
                    color: AppColors.primaryColor.opacity(0.3),
                    radius: 2,
                    x: 0,
                    y: 0
                )
            
            VStack(alignment: .center) {
                Image(systemName: "exclamationmark")
                    .font(.custom(AppFonts.extraLight, size: AppFontSizes.body))
                    .foregroundColor(AppColors.primaryColor)
                
                Text("Oops!\nImage fetch failed.")
                    .font(.custom(AppFonts.extraLight, size: AppFontSizes.caption))
                    .multilineTextAlignment(.center)
                    .foregroundColor(AppColors.accentColor)
            }
        }
    }
}
