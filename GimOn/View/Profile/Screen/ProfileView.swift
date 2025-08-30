//
//  ProfileView.swift
//  GimOn
//
//  Created by Enjel Hutasoit on 31/07/25.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        ScrollView {
            VStack {
                HStack(alignment: .center, spacing: 12) {
                    PhotoProfile(
                        image: Image(User.photo),
                        size: CGSize(width: 100, height: 100),
                        borderWidth: 3
                    )
                    
                    UserBioView(
                        name: User.fullName,
                        username: User.username,
                        bio: User.bio
                    )
                }
                
                BorderedButton(User.web, fixedWidth: false) {
                    openURLInBrowser(User.webURL)
                }
                .frame(maxWidth: .infinity)
                .padding(.top)
            }
        }
        .padding(.horizontal)
        .background(.black)
    }
}
