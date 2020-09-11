//
//  User+CoreDataProperties.swift
//  PersistedJSON
//
//  Created by Алтын on 9/10/20.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var name: String
    @NSManaged public var age: Int16
    @NSManaged public var id: Int16

}
