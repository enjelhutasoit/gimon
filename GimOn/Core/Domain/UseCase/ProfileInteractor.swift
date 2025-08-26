//
//  ProfileInteractor.swift
//  GimOn
//
//  Created by Enjel Hutasoit on 26/08/25.
//

import Foundation

class ProfileInteractor {
    private let repository: ProfileRespositoryProtocol
    
    init(repository: ProfileRespositoryProtocol) {
        self.repository = repository
    }
}

extension ProfileInteractor: ProfileUseCase {
    func getProfile() -> ProfileModel {
        repository.getProfile()
    }

    func updateProfile(_ profile: ProfileModel) {
        repository.updateProfile(profile)
    }
}
