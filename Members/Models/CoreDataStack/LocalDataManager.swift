//
//  LocalDataManager.swift
//  Members
//
//  Created by Misael Pérez Chamorro on 19/08/20.
//  Copyright © 2020 Misael Pérez Chamorro. All rights reserved.
//
import CoreData

class LocalDataManager: NSObject {
  static let sharedInstance = LocalDataManager()

  lazy var persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "Members")
    container.loadPersistentStores(completionHandler: { (_, error) in
      if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    })
    return container
  }()

  private override init() {
    super.init()
  }
}
