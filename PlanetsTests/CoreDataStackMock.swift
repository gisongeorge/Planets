//
//  CoreDataStackMock.swift
//  PlanetsTests
//
//  Created by Gisonmon George on 13/05/23.
//

import Foundation
@testable import Planets
import CoreData

/*
 Core Data Stack mock class created to inject to test cases
 */
class CoreDataStackMock: CoreDataStackProtocol {
    
    var persistentContainer: NSPersistentContainer
    
    init() {
        let managedObjectModel = NSManagedObjectModel.mergedModel(from: [Bundle.main])!
        persistentContainer = NSPersistentContainer(name: "TestingContainer", managedObjectModel: managedObjectModel)
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        persistentContainer.persistentStoreDescriptions = [description]
        persistentContainer.loadPersistentStores { (description, error) in
            precondition(description.type == NSInMemoryStoreType)
        }
    }
    
    func saveContext() {}
}
