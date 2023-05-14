//
//  Constants.swift
//  Planets
//
//  Created by Gisonmon George on 12/05/23.
//

import Foundation

// MARK: Server end point
struct ApiEndPoints {
    static let planets = "https://swapi.dev/api/planets/"
}

// MARK: App Messages
struct Messages {
    static let apiError = "Oops, there is an error while loading planets. Please try again"
    static let noResultFound = "Oops, We are not able to find any planets."
    static let xibLoadingError = "xib does not exists"
}
