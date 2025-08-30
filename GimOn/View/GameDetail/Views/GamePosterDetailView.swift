//
//  GamePosterDetailView.swift
//  GimOn
//
//  Created by Enjel Hutasoit on 01/08/25.
//

import SwiftUI

struct GamePosterDetailView: View {
    let posterURL: URL?
    let height: CGFloat
    let width: CGFloat
    
    var body: some View {
        AsyncImage(url: posterURL) { phase in
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
        .overlay(gradient)
    }
}

extension GamePosterDetailView {
    private func loadedView(with image: Image) -> some View {
        image
            .resizable()
            .scaledToFill()
            .frame(width: width, height: height)
            .clipped()
    }
    
    private var loadingView: some View {
        ProgressView()
    }
    
    private var errorView: some View {
        VStack(alignment: .center) {
            Image(systemName: "exclamationmark")
                .font(.custom(AppFonts.extraLight, size: AppFontSizes.body))
                .foregroundColor(AppColors.primaryColor)
            
            Text("Oops!\nImage fetch failed.")
                .font(.custom(AppFonts.extraLight, size: AppFontSizes.body))
                .multilineTextAlignment(.center)
                .foregroundColor(AppColors.accentColor)
        }
    }
    
    private var gradient: some View {
        LinearGradient(
            gradient: Gradient(
                colors: [
                    .clear,
                    .clear,
                    .clear,
                    .black
                ]
            ),
            startPoint: .top,
            endPoint: .bottom
        )
    }
}
