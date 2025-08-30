//
//  GameEntity.swift
//  GimOn
//
//  Created by Enjel Hutasoit on 26/08/25.
//

import Foundation
import RealmSwift

class GameEntity: Object {
    
    @Persisted var backgroundImage: String = ""
    @Persisted var genres = List<GenreEntity>()
    @Persisted var id: Int = 0
    @Persisted var favorite: Bool = false
    @Persisted var name: String = ""
    @Persisted var parentPlatforms = List<ParentPlatformEntity>()
    @Persisted var playtime: Int = 0
    @Persisted var rating: Double = 0.0
    @Persisted var ratingCount: Int = 0
    @Persisted var released: String = ""
    
    override static func primaryKey() -> String? {
      return "id"
    }
}

class GenreEntity: Object {
    @Persisted var name: String?
}

class ParentPlatformEntity: Object {
    @Persisted var platform: PlatformEntity?
}

class PlatformEntity: Object {
    @Persisted var name: String?
    @Persisted var slug: String?
}
