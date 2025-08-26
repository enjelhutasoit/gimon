//
//  EditProfileView.swift
//  GimOn
//
//  Created by Enjel Hutasoit on 08/08/25.
//

import SwiftUI

struct EditProfileView: View {
    
    @Environment(\.dismiss) private var dismiss
        
    @ObservedObject var presenter: ProfilePresenter

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                ProfileRowView(
                    title: "Name",
                    value: presenter.profile.fullname
                ) {
                    presenter.onTapFullName()
                }
                
                ProfileRowView(
                    title: "Username",
                    value: presenter.profile.username
                ) {
                    presenter.onTapEditUsername()
                }
                
                ProfileRowView(
                    title: "Bio",
                    value: presenter.profile.bio
                ) {
                    presenter.onTapEditBio()
                }
            }
            .padding()
        }
        .navigationDestination(
            isPresented: $presenter.isNavigatingToEditor
        ) {
            presenter.editorDestination
        }
        .onAppear {
            presenter.getProfile()
        }
        .toolbarBackground(.black, for: .navigationBar)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                BackArrowButton { dismiss() }
            }
            
            ToolbarItem(placement: .principal) {
                Text("Edit Profile")
                    .font(.custom(AppFonts.extraBold, size: AppFontSizes.title2))
                    .foregroundStyle(AppColors.primaryColor)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .background(.black)
    }
}
