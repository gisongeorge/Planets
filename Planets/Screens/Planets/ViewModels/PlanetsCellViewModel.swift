//
//  PlanetsCellViewModel.swift
//  Planets
//
//  Created by Gisonmon George on 13/05/23.
//

import Foundation

/*
 View model to show the planet name in table view cell
 */
struct PlanetsCellViewModel {
    
    let name: String?
}

extension PlanetsCellViewModel {
    
    init(data: PlanetsEntity) {
        // Can add any thing extra which is needed for UI population.
        self.name = data.name
    }
}
