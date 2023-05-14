//
//  PlanetsDBService.swift
//  Planets
//
//  Created by Gisonmon George on 13/05/23.
//

import Foundation
import CoreData

/*
 Protocol for handling DB operations
 */
protocol PlanetsDBServiceProtocol {
    func savePlanetsToDb(planets: PlanetsModel?, completion: @escaping ()->())
    func loadPlanetsFromDb() -> [PlanetsCellViewModel]
    func deleteAllPlanets()
}

/*
 Database Service class for handling DB operations
 It contains a coreDataStack object, which is created by using dependency injection
 */
class PlanetsDBService: PlanetsDBServiceProtocol {
    
    private var coreDataStack: CoreDataStackProtocol
    private var lastIndex = 0
    
    init(stack: CoreDataStackProtocol) {
        self.coreDataStack = stack
    }
    
    // Save planet data to DB
    // Keeping index for saving the data in the same order
    // Capable for handling paginations
    func savePlanetsToDb(planets: PlanetsModel?, completion: @escaping ()->()) {
        if let planets, let results = planets.results {
            let context = coreDataStack.persistentContainer.viewContext
            var currentIndex = 0
            for (index, result) in results.enumerated() {
                currentIndex = index + 1
                let entity = PlanetsEntity(context:context)
                entity.parseWith(response: result, index: lastIndex + currentIndex)
            }
            lastIndex = lastIndex + currentIndex
            coreDataStack.saveContext()
            completion()
        } else {
            // Do nothing -  no error, response is empty
            completion()
        }

    }
    
    // Load planets data from DB
    func loadPlanetsFromDb() -> [PlanetsCellViewModel] {
        let context = coreDataStack.persistentContainer.viewContext
        var modelArray = [PlanetsCellViewModel]()
        do {
            let planets : [PlanetsEntity] = try context.fetch(PlanetsEntity.fetchRequest())
            for planet in planets where planets.count > 0 {
                let resultModel = PlanetsCellViewModel(data: planet)
                modelArray.append(resultModel)
            }
        } catch {
            print("Error fetching data from CoreData")
        }
        return modelArray
    }
    
    // Delete all planet data from DB
    func deleteAllPlanets() {
        let context = coreDataStack.persistentContainer.viewContext
        do {
            let planets : [PlanetsEntity] = try context.fetch(PlanetsEntity.fetchRequest())
            for planet in planets where planets.count > 0 {
                context.delete(planet)
            }
        } catch let error {
            print("Detele all error :", error)
        }
    }
}
