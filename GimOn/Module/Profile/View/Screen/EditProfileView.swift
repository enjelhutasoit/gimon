//
//  EditProfileView.swift
//  GimOn
//
//  Created by Enjel Hutasoit on 08/08/25.
//

import SwiftUI

struct EditProfileView: View {
    
    @State private var isEditingName: Bool = false
    @State private var isEditingUsername: Bool = false
    @State private var isEditingBio: Bool = false

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
                ) { isEditingName.toggle() }
                
                ProfileRowView(
                    title: "Username",
                    value: username
                ) { isEditingUsername.toggle() }
                
                ProfileRowView(
                    title: "Bio",
                    value: bio
                ) { isEditingBio.toggle() }
            }
            .padding()
        }
        .navigationDestination(isPresented: $isEditingName) {
            ProfileEditorView(
                navTitle: "Name",
                inputPlaceholder: "Name",
                instruction: "What do your fellow adventurers call you? \n\nDrop your real name or your legendary alias 👑 — it’s how we’ll recognize your epic feats.",
                inputValue: $name,
                onSave: {
                    ProfileStore.shared.name = name
                }
            )
        }
        .navigationDestination(isPresented: $isEditingUsername) {
            ProfileEditorView(
                navTitle: "Username",
                inputPlaceholder: "Username",
                instruction: "This is your gamer tag, your battle ID. \n\nMake it unforgettable, and make sure it’s uniquely yours — no evil 😈 twins allowed.",
                inputValue: $username,
                onSave: {
                    ProfileStore.shared.username = username
                }
            )
        }
        .navigationDestination(isPresented: $isEditingBio) {
            ProfileEditorView(
                navTitle: "Bio",
                inputPlaceholder: "Bio",
                instruction: "Who are you in the realm of gaming? \n\nA fearless dragon slayer? \ncozy farming simulator god? \n\nTell us your story… or leave it a mystery 🕸️.",
                inputValue: $bio,
                onSave: {
                    ProfileStore.shared.bio = bio
                }
            )
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
