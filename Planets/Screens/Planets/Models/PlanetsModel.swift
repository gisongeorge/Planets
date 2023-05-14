//
//  PlanetsModel.swift
//  Planets
//
//  Created by Gisonmon George on 12/05/23.
//

import Foundation

/*
 Model used to map the planets API response.
 */
struct PlanetsModel : Codable {
    
    let count : Int?
    let next : String?
    let previous : String?
    let results : [PlanetResult]?

    enum CodingKeys: String, CodingKey {
        case count = "count"
        case next = "next"
        case previous = "previous"
        case results = "results"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        count = try values.decodeIfPresent(Int.self, forKey: .count)
        next = try values.decodeIfPresent(String.self, forKey: .next)
        previous = try values.decodeIfPresent(String.self, forKey: .previous)
        results = try values.decodeIfPresent([PlanetResult].self, forKey: .results)
    }
}

/*
 Model used to map the planet API response.
 */
struct PlanetResult : Codable {
    
    let name : String?

    enum CodingKeys: String, CodingKey {
        case name = "name"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name)
    }
}
