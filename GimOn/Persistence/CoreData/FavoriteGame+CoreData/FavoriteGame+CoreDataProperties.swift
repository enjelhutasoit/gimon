//
//  FavoriteGame+CoreDataProperties.swift
//  GimOn
//
//  Created by Enjel Hutasoit on 08/08/25.
//
//

import Foundation
import CoreData

extension FavoriteGame {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteGame> {
        return NSFetchRequest<FavoriteGame>(entityName: "FavoriteGame")
    }

    @NSManaged public var id: Int32
    @NSManaged public var name: String?
    @NSManaged public var backgroundImage: String?
    @NSManaged public var playtime: String?
    @NSManaged public var rating: String?
    @NSManaged public var ratingCount: String?
    @NSManaged public var released: String?
    @NSManaged public var genres: [String]?
    @NSManaged public var parentPlatforms: [String]?

}
