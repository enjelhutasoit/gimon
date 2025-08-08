//
//  ProfileView.swift
//  GimOn
//
//  Created by Enjel Hutasoit on 31/07/25.
//

import SwiftUI

struct ProfileView: View {
    
    @AppStorage(ProfileStore.nameKey) var name = ProfileStore.shared.name
    @AppStorage(ProfileStore.usernameKey) var username = ProfileStore.shared.username
    @AppStorage(ProfileStore.bioKey) var bio = ProfileStore.shared.bio
    
    var body: some View {
        ScrollView {
            VStack {
                HStack(alignment: .center, spacing: 12) {
                    PhotoProfile(
                        image: Image(DefaultUser.photo),
                        size: CGSize(width: 100, height: 100),
                        borderWidth: 3
                    )
                    
                    UserBioView(
                        name: name,
                        username: username,
                        bio: bio
                    )
                }
                
                BorderedButton(DefaultUser.web, fixedWidth: false) {
                    openURLInBrowser(DefaultUser.webURL)
                }
                .frame(maxWidth: .infinity)
                .padding(.top)
            }
        }
        .padding(.horizontal)
        .background(.black)
    }
}
