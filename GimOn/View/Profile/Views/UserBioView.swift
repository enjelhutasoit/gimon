//
//  UserBioView.swift
//  GimOn
//
//  Created by Enjel Hutasoit on 31/07/25.
//

import SwiftUI

struct UserBioView: View {
    let name: String
    let username: String
    let bio: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            makeName(name: DefaultUser.fullName, font: .custom(AppFonts.bold, size: 18))
            makeName(name: DefaultUser.username, font: .custom(AppFonts.light, size: 16))
            makeBio(with: DefaultUser.bio)
                .padding(.top, 12)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private func makeBio(with bio: String) -> some View {
        Text(bio)
            .font(.custom(AppFonts.extraLight, size: AppFontSizes.body))
            .foregroundColor(AppColors.primaryTextColor)
    }

    private func makeName(name: String, font: Font) -> some View {
        Text(name)
            .lineLimit(1)
            .font(font)
            .foregroundStyle(
                LinearGradient(
                    gradient: Gradient(
                        colors: [
                            AppColors.primaryTextColor,
                            AppColors.primaryColor
                        ]
                    ),
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
    }
}
