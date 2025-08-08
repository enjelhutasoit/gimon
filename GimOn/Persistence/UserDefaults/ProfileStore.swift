//
//  ProfileStore.swift
//  GimOn
//
//  Created by Enjel Hutasoit on 08/08/25.
//

import Foundation

struct ProfileStore {
    static let nameKey = "name"
    static let usernameKey = "username"
    static let bioKey = "bio"
    
    static var shared = ProfileStore()
    
    var name: String {
        get { UserDefaults.standard.string(forKey: Self.nameKey) ?? DefaultUser.fullName }
        set { UserDefaults.standard.set(newValue, forKey: Self.nameKey) }
    }
    
    var username: String {
        get { UserDefaults.standard.string(forKey: Self.usernameKey) ?? DefaultUser.username }
        set { UserDefaults.standard.set(newValue, forKey: Self.usernameKey) }
    }
    
    var bio: String {
        get { UserDefaults.standard.string(forKey: Self.bioKey) ?? DefaultUser.bio }
        set { UserDefaults.standard.set(newValue, forKey: Self.bioKey) }
    }
}
