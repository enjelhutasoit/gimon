//
//  ProfileView.swift
//  GimOn
//
//  Created by Enjel Hutasoit on 31/07/25.
//

import SwiftUI

struct ProfileView: View {
    
    @ObservedObject var presenter: ProfilePresenter
    
    var body: some View {
        ScrollView {
            VStack {
                HStack(alignment: .center, spacing: 12) {
                    PhotoProfile(
                        image: Image(DefaultProfile.photo),
                        size: CGSize(width: 100, height: 100),
                        borderWidth: 3
                    )
                    
                    UserBioView(
                        name: presenter.profile.fullname,
                        username: presenter.profile.username,
                        bio: presenter.profile.bio
                    )
                }
                
                HStack(alignment: .center, spacing: 12) {
                    BorderedButton("Edit Profile", fixedWidth: false) {
                        presenter.onTapEditProfile()
                    }
                    
                    BorderedButton(DefaultProfile.web, fixedWidth: false) {
                        openURLInBrowser(DefaultProfile.webURL)
                    }
                }
                .padding(.top)
            }
            .padding(.horizontal)
        }
        .onAppear {
            presenter.getProfile()
        }
        .navigationDestination(
            isPresented: $presenter.isNavigatingToEditProfile
        ) {
            presenter.editProfileDestination
        }
        .background(.black)
    }
}
