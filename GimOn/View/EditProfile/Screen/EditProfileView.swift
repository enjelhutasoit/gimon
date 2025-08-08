//
//  EditProfileView.swift
//  GimOn
//
//  Created by Enjel Hutasoit on 08/08/25.
//

import SwiftUI

struct EditProfileView: View {
    @Environment(\.dismiss) var dismiss
    
    @AppStorage(ProfileStore.nameKey) var name: String = ProfileStore.shared.name
    @AppStorage(ProfileStore.usernameKey) var username: String = ProfileStore.shared.username
    @AppStorage(ProfileStore.bioKey) var bio: String = ProfileStore.shared.bio
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                ProfileRowView(
                    title: "Name",
                    value: name
                ) { }
                
                ProfileRowView(
                    title: "Username",
                    value: username
                ) { }
                
                ProfileRowView(
                    title: "Bio",
                    value: bio
                ) { }
            }
            .padding()
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
