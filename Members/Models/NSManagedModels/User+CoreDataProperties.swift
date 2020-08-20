//
//  User+CoreDataProperties.swift
//  Members
//
//  Created by Misael Pérez Chamorro on 19/08/20.
//  Copyright © 2020 Misael Pérez Chamorro. All rights reserved.
//
//

import Foundation
import CoreData


extension User {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }
    @NSManaged public var name: String?
    @NSManaged public var email: String?
    @NSManaged public var id: Int32
    @NSManaged public var password: String?
}
