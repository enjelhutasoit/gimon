//
//  GameDetailEntity.swift
//  GimOn
//
//  Created by Enjel Hutasoit on 26/08/25.
//

import Foundation
import RealmSwift

class GameDetailEntity: Object {
    @Persisted var alternativeNames = List<String>()
    @Persisted var backgroundImage: String = ""
    @Persisted var descriptionRaw: String = ""
    @Persisted var developers = List<String>()
    @Persisted var esrbRating: String = ""
    @Persisted var favorite: Bool = false
    @Persisted var genres = List<String>()
    @Persisted var id: Int = 0
    @Persisted var metacritic: Int = 0
    @Persisted var metacriticURL: String = ""
    @Persisted var name: String = ""
    @Persisted var parentPlatforms = List<ParentPlatformEntity>()
    @Persisted var playtime: Int = 0
    @Persisted var rating: Double = 0.0
    @Persisted var ratingsCount: Int = 0
    @Persisted var redditURL: String = ""
    @Persisted var released: String = ""
    @Persisted var stores = List<StoreEntity>()
    @Persisted var tags = List<String>()
    @Persisted var website: String = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

class StoreEntity: Object {
    @Persisted var storeDetail: StoreDetailEnttity?
}

class StoreDetailEnttity: Object {
    @Persisted var name: String = ""
    @Persisted var domain: String = ""
}
