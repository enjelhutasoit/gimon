//
//  SearchView.swift
//  GimOn
//
//  Created by Enjel Hutasoit on 31/07/25.
//

import SwiftUI

struct SearchView: View {
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            Text("This feature is coming soon! 🚀")
                .font(.custom(AppFonts.semiBold, size: AppFontSizes.title3))
                .foregroundStyle(
                    LinearGradient(
                        gradient: Gradient(
                            colors: [
                                AppColors.primaryTextColor,
                                AppColors.primaryColor,
                                AppColors.primaryTextColor
                            ]
                        ),
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
