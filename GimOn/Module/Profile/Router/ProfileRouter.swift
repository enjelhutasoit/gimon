//
//  ProfileRouter.swift
//  GimOn
//
//  Created by Enjel Hutasoit on 26/08/25.
//

import SwiftUI

final class ProfileRouter {
    func makeEditProfileView() -> some View {
        let interactor = Injection.init().provideProfileUseCase()
        let presenter = ProfilePresenter(useCase: interactor)
        return EditProfileView(presenter: presenter)
    }
    
    func makeProfileEditorView(
        navTitle: String,
        inputPlaceholder: String,
        instruction: String,
        initialInputValue: String,
        onSave: @escaping (String) -> Void
    ) -> AnyView {
        AnyView(
            ProfileEditorView(
                navTitle: navTitle,
                inputPlaceholder: inputPlaceholder,
                instruction: instruction,
                initialInputValue: initialInputValue,
                onSave: onSave
            )
        )
    }
}
