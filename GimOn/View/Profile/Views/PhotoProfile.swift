//
//  PhotoProfile.swift
//  GimOn
//
//  Created by Enjel Hutasoit on 31/07/25.
//

import SwiftUI

struct PhotoProfile: View {
    
    let image: Image
    let size: CGSize
    let borderWidth: CGFloat
    
    private var profileGradient: LinearGradient {
        LinearGradient(
            gradient: Gradient(
                colors: [
                    AppColors.primaryColor,
                    AppColors.primaryColor.opacity(0.75),
                    AppColors.primaryColor.opacity(0.5),
                    AppColors.primaryColor.opacity(0.25),
                    .clear
                ]
            ),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
    
    var body: some View {
        ZStack {
            Circle()
                .fill(profileGradient)
                .frame(width: size.width, height: size.height)
                .clipShape(Circle())
            
            image
                .resizable()
                .scaledToFill()
                .frame(width: size.width - borderWidth, height: size.height - borderWidth)
                .clipShape(Circle())
        }
    }
}
