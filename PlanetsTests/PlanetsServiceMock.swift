//
//  PlanetsServiceMock.swift
//  PlanetsTests
//
//  Created by Gisonmon George on 13/05/23.
//

import Foundation
@testable import Planets

enum ErrorCase {
    case success, failure, emptyResponse
}

/*
 Service mock class created to inject to test cases
 */
class PlanetsServiceMock: PlanetsServiceProtocol {
    
    var testScenario:ErrorCase = .success
    
    // MARK: Get Acronyms
    func getPlanets(url: String, completion: @escaping (PlanetsModel?, ApiError?) -> ()) {
        switch testScenario {
        case .success:
            if let data = TestUtils.readLocalFile(forName: "PlanetsModelStub") {
                let decoder = JSONDecoder()
                if let json = try? decoder.decode(PlanetsModel.self, from: data) {
                    completion(json, nil)
                }
            }
        case .failure:
            completion(nil, .noData)
        case .emptyResponse:
            completion(nil, nil)
        }
    }
    
}
