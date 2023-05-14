//
//  PlanetsTableViewCell.swift
//  Planets
//
//  Created by Gisonmon George on 13/05/23.
//

import UIKit

/*
 TableView cell class for loading planet name.
 */
class PlanetsTableViewCell: UITableViewCell {

    @IBOutlet weak var planetName: UILabel!
    
    // Use this model to bind the data to cell
    var planet: PlanetsCellViewModel? {
        didSet {
            planetName.text = planet?.name
        }
    }
}
