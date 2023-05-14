//
//  PlanetsServiceTests.swift
//  PlanetsTests
//
//  Created by Gisonmon George on 14/05/23.
//

import XCTest
@testable import Planets

final class PlanetsServiceTests: XCTestCase {

    var planetsService: PlanetsService!
    
    override func setUp() {
        super.setUp()
        planetsService = PlanetsService(apiHandler: ApiHandlerMock())
    }
    
    override func tearDown() {
        super.tearDown()
        planetsService = nil
    }

    func testGetPlanetsSuccess() {
        planetsService.getPlanets(url: "FakeEndPoint") { planets, apiError in
            XCTAssertNotNil(planets)
            XCTAssertTrue(planets?.count ?? 0 > 0)
            XCTAssertNil(apiError)
        }
    }
    
    func testGetPlanetsFailure() {
        planetsService.getPlanets(url: "") { planets, apiError in
            XCTAssertNil(planets)
            XCTAssertNotNil(apiError)
        }
    }
    
}
