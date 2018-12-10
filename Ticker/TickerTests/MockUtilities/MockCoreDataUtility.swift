//
//  MockCoreDataUtility.swift
//  TickerTests
//
//  Created by Mandha Smitha S on 12/10/18.
//  Copyright © 2018 Smitha. All rights reserved.
//

import UIKit
import CoreData

class MockCoreDataUtility {
    class func managedObjectContext() -> NSManagedObjectContext {
        let managedObjectModel = NSManagedObjectModel.mergedModel(from: [Bundle.main])!
        let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
        do {
            try persistentStoreCoordinator.addPersistentStore(ofType: NSInMemoryStoreType, configurationName: nil, at: nil, options: nil)
        } catch {
            print("Failure - Could not add In-memory persistentStore")
        }
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = persistentStoreCoordinator
        return managedObjectContext
    }
}
