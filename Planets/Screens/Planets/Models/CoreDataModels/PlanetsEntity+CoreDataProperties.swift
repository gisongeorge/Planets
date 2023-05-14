//
//  PlanetsEntity+CoreDataProperties.swift
//  Planets
//
//  Created by Gisonmon George on 14/05/23.
//
//

import Foundation
import CoreData


extension PlanetsEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PlanetsEntity> {
        let fetchRequest = NSFetchRequest<PlanetsEntity>(entityName: "PlanetsEntity")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "displayOrder", ascending: true)]
        return fetchRequest
    }

    @NSManaged public var name: String?
    @NSManaged public var displayOrder: Float

    func parseWith(response: PlanetResult, index: Int){
        self.displayOrder = Float(index)
        self.name = response.name
    }
}
