//
//  User+CoreDataClass.swift
//  Members
//
//  Created by Misael Pérez Chamorro on 19/08/20.
//  Copyright © 2020 Misael Pérez Chamorro. All rights reserved.
//
//

import Foundation
import CoreData


public class User: NSManagedObject {
  static func createFromPayload(usersPayload: [AllusersQuery.Data.User?],
                                completion: @escaping () -> Void) {
    for userData in usersPayload {
      let userId = Int32(userData!.id!)!
      if !userExist(userId: userData!.id!) {
        let user = User.create() as? User
        user?.id = userId
        user?.name =  userData?.name
        user?.email = userData?.email
        user?.save()
      }
    }
    completion()
  }
  
  static func userExist(userId: String) -> Bool {
    if User.findBy(value: userId, field: "id") != nil {
      return true
    } else {
      return false
    }
  }
}
