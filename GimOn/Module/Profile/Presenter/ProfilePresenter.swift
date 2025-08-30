//
//  ProfilePresenter.swift
//  GimOn
//
//  Created by Enjel Hutasoit on 26/08/25.
//

import SwiftUI

class ProfilePresenter: ObservableObject {
    
    @Published var editorDestination: AnyView?
    @Published var editProfileDestination: AnyView?
    @Published var isNavigatingToEditor: Bool = false
    @Published var isNavigatingToEditProfile: Bool = false
    @Published var profile: ProfileModel
    
    private let router = ProfileRouter()
    private let useCase: ProfileUseCase
    
    init(useCase: ProfileUseCase) {
        self.useCase = useCase
        self.profile = ProfileModel(
            bio: DefaultProfile.bio,
            fullname: DefaultProfile.fullName,
            username: DefaultProfile.username
        )
    }
    
    func getProfile() {
        profile = useCase.getProfile()
    }
    
    func updateProfileName(_ name: String) {
        profile.fullname = name
        useCase.updateProfile(profile)
    }
    
    func updateProfileUsername(_ username: String) {
        profile.username = username
        useCase.updateProfile(profile)
    }
    
    func updateProfileBio(_ bio: String) {
        profile.bio = bio
        useCase.updateProfile(profile)
    }
}

extension ProfilePresenter {
    func onTapEditProfile() {
        editProfileDestination = AnyView(router.makeEditProfileView())
        isNavigatingToEditProfile = true
    }
    
    func onTapFullName() {
        editorDestination = router.makeProfileEditorView(
            navTitle: ProfileFieldType.name.title,
            inputPlaceholder: ProfileFieldType.name.title,
            instruction: ProfileFieldType.name.instruction,
            initialInputValue: profile.fullname,
            onSave: { [weak self] name in
                self?.updateProfileName(name)
            }
        )
        isNavigatingToEditor = true
    }
    
    func onTapEditUsername() {
        editorDestination = router.makeProfileEditorView(
            navTitle: ProfileFieldType.username.title,
            inputPlaceholder: ProfileFieldType.username.title,
            instruction: ProfileFieldType.username.instruction,
            initialInputValue: profile.username,
            onSave: { [weak self] username in
                self?.updateProfileUsername(username)
            }
        )
        isNavigatingToEditor = true
    }
    
    func onTapEditBio() {
        editorDestination = router.makeProfileEditorView(
            navTitle: ProfileFieldType.bio.title,
            inputPlaceholder: ProfileFieldType.bio.title,
            instruction: ProfileFieldType.bio.instruction,
            initialInputValue: profile.bio,
            onSave: { [weak self] newBio in
                self?.updateProfileBio(newBio)
            }
        )
        isNavigatingToEditor = true
    }
}

enum ProfileFieldType {
    case bio, name, username
    
    var title: String {
        switch self {
        case .bio: "Bio"
        case .name: "Name"
        case .username: "Username"
        }
    }
    
    var instruction: String {
        switch self {
        case .bio:
            "Who are you in the realm of gaming? \n\nA fearless dragon slayer? \ncozy farming simulator god? \n\nTell us your story… or leave it a mystery 🕸️."
        case .name:
            "What do your fellow adventurers call you? \n\nDrop your real name or your legendary alias 👑 — it’s how we’ll recognize your epic feats."
        case .username:
            "This is your gamer tag, your battle ID. \n\nMake it unforgettable, and make sure it’s uniquely yours — no evil 😈 twins allowed."
        }
    }
}
