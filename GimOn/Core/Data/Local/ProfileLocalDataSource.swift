//
//  ProfileLocalDataSource.swift
//  GimOn
//
//  Created by Enjel Hutasoit on 26/08/25.
//

import Foundation

protocol ProfileLocalDataSourceProtocol: AnyObject {
    func getProfile() -> ProfileEntity
    func updateProfile(_ entity: ProfileEntity)
}

final class ProfileLocalDataSource: NSObject {
    private struct ProfileKeys {
        static let bio = "bio"
        static let name = "name"
        static let username = "username"
    }

    private let userDefault: UserDefaults
    
    init(userDefault: UserDefaults) {
        self.userDefault = userDefault
    }
}

extension ProfileLocalDataSource: ProfileLocalDataSourceProtocol {
    func getProfile() -> ProfileEntity {
        ProfileEntity(
            bio: userDefault.string(forKey: ProfileKeys.bio) ?? DefaultProfile.bio,
            fullname: userDefault.string(forKey: ProfileKeys.name) ?? DefaultProfile.fullName,
            username: userDefault.string(forKey: ProfileKeys.username) ?? DefaultProfile.username
        )
    }
    
    func updateProfile(_ entity: ProfileEntity) {
        userDefault.set(entity.bio, forKey: ProfileKeys.bio)
        userDefault.set(entity.fullname, forKey: ProfileKeys.name)
        userDefault.set(entity.username, forKey: ProfileKeys.username)
    }
}
