//
//  ManagedObjectActiveRecordExtension.swift
//
//  Created by Misael Pérez Chamorro on 7/2/18.
//  Copyright © 2018 Misael Pérez Chamorro. All rights reserved.
//

import CoreData

extension NSManagedObject {
  static func create() -> NSManagedObject {
    let localDataManager  = LocalDataManager.sharedInstance
    let context = localDataManager.persistentContainer.viewContext
    return NSEntityDescription.insertNewObject(forEntityName: entityName(), into: context)
  }

  static func entityName() -> String {
    let entityName = NSStringFromClass(self.self)
    return entityName.replacingOccurrences(of: "Members.", with: "")
  }

  func save() {
    let localDataManager  = LocalDataManager.sharedInstance
    let context = localDataManager.persistentContainer.viewContext
    if context.hasChanges {
      do {
        try context.save()
      } catch {
        let nserror = error as NSError
        fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
      }
    }
  }

  static func findBy(value: String, field: String) -> NSManagedObject? {
    let request = NSFetchRequest<NSFetchRequestResult>()
    let localDataManager  = LocalDataManager.sharedInstance
    let context = localDataManager.persistentContainer.viewContext
    request.entity = NSEntityDescription.entity(forEntityName: entityName(), in: context)
    let predicate = NSPredicate(format: "\(field) = %@", value)
    request.predicate = predicate
    do {
      let results = try context.fetch(request) as? [NSManagedObject]
      return results?.first
    } catch {
      NSLog("Unable to fetch local information")
      return nil
    }
  }

  static func findBy(online: Bool, field: String) -> [NSManagedObject] {
    let request = NSFetchRequest<NSFetchRequestResult>()
    let localDataManager  = LocalDataManager.sharedInstance
    let context = localDataManager.persistentContainer.viewContext
    request.entity = NSEntityDescription.entity(forEntityName: entityName(), in: context)
    let predicate = NSPredicate(format: "\(field) = %@", NSNumber(value: online))
    let sortDescriptor = NSSortDescriptor(key: "isInstructor", ascending: false)
    request.predicate = predicate
    request.sortDescriptors = [sortDescriptor]
    do {
      let results = try context.fetch(request) as? [NSManagedObject]
      return results!
    } catch {
      NSLog("Unable to fetch local information")
      return []
    }
  }

  static func findAll() -> [NSManagedObject] {
    let request = NSFetchRequest<NSFetchRequestResult>()
    let localDataManager  = LocalDataManager.sharedInstance
    let context = localDataManager.persistentContainer.viewContext
    request.entity = NSEntityDescription.entity(forEntityName: entityName(), in: context)
    do {
      let results = try context.fetch(request) as? [NSManagedObject]
      return results!
    } catch {
      NSLog("Unable to fetch local information")
      return []
    }
  }

  static func deleteAll() -> [NSManagedObject] {
    let request = NSFetchRequest<NSFetchRequestResult>()
    let localDataManager  = LocalDataManager.sharedInstance
    let context = localDataManager.persistentContainer.viewContext
    request.entity = NSEntityDescription.entity(forEntityName: entityName(), in: context)
    do {
      let results = try context.fetch(request) as? [NSManagedObject]
      if results != nil {
        for result in results! {
          context.delete(result)
        }
      }

      try context.save()
      return []
    } catch {
      NSLog("Unable to fetch local information")
      return []
    }
  }
  
  static func resultsController() -> NSFetchedResultsController<NSFetchRequestResult> {
    let localDataManager  = LocalDataManager.sharedInstance
    let context = localDataManager.persistentContainer.viewContext
    let request = NSFetchRequest<NSFetchRequestResult>()
    request.entity = NSEntityDescription.entity(forEntityName: entityName(), in: context)
    request.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
    
    let controller = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
    do {
      try controller.performFetch()
      return controller
    } catch {
      fatalError("Failed to fetch entities: \(error)")
    }
  }
}

