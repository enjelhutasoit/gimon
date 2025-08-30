//
//  ProfileRepository.swift
//  GimOn
//
//  Created by Enjel Hutasoit on 26/08/25.
//

import Foundation

protocol ProfileRespositoryProtocol {
    func getProfile() -> ProfileModel
    func updateProfile(_ profile: ProfileModel)
}

final class ProfileRespository: NSObject {
    
    private let local: ProfileLocalDataSource
    
    init(local: ProfileLocalDataSource) {
        self.local = local
    }
}

extension ProfileRespository: ProfileRespositoryProtocol {
    func getProfile() -> ProfileModel {
        let entity = local.getProfile()
        return ProfileModel(
            bio: entity.bio,
            fullname: entity.fullname,
            username: entity.username
        )
    }
    
    func updateProfile(_ profile: ProfileModel) {
        let entity = ProfileEntity(
            bio: profile.bio,
            fullname: profile.fullname,
            username: profile.username
        )
        local.updateProfile(entity)
    }
}
