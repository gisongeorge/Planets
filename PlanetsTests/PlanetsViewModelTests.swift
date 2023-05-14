//
//  PlanetsTests.swift
//  PlanetsTests
//
//  Created by Gisonmon George on 12/05/23.
//

import XCTest
@testable import Planets

final class PlanetsViewModelTests: XCTestCase {

    var viewModel: PlanetsViewModel!
    var planetsService: PlanetsServiceMock!
    var planetsDBService: PlanetsDBService!
    
    override func setUp() {
        super.setUp()
        planetsService = PlanetsServiceMock()
        planetsDBService = PlanetsDBService(stack: CoreDataStackMock())
        viewModel = PlanetsViewModel(planetsService: planetsService, planetsDBService: planetsDBService)
    }

    override func tearDown() {
        super.tearDown()
        viewModel = nil
        planetsService = nil
        planetsDBService = nil
    }
    
    func testGetPlanetsInvalidRequestReturnEmptyResponse() {
        planetsService.testScenario = .emptyResponse
        let expectation = self.expectation(description: #function)
        viewModel.getPlanets {
            XCTAssertTrue(self.viewModel?.planetsResults.count == 0)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10)
    }
    
    func testGetPlanetsInvalidRequestReturnApiErrorResponse() {
        planetsService.testScenario = .failure
        let expectation = self.expectation(description: #function)
        viewModel.getPlanets {
            XCTAssertTrue(self.viewModel?.planetsResults.count == 0)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10)
    }

    func testGetPlanetsValidRequestReturnResponse() {
        planetsService.testScenario = .success
        let expectation = self.expectation(description: #function)
        viewModel.getPlanets {
            XCTAssertTrue(self.viewModel.planetsResults.count > 0)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10)
    }
    
    func testNumberOfRows() {
        let expectation = self.expectation(description: #function)
        var responseCount:Int = 0
        viewModel.getPlanets {
            XCTAssertTrue(self.viewModel.planetsResults.count > 0)
            responseCount = self.viewModel.planetsResults.count
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10)
        let numberOfRows = viewModel.numberOfRows()
        XCTAssertEqual(responseCount, numberOfRows)
    }
    
    func testGetPlanetsCellModel() {
        let expectation = self.expectation(description: #function)
        viewModel.getPlanets {
            XCTAssertTrue(self.viewModel.planetsResults.count > 0)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10)
        let cellForRow = viewModel.getPlanetsCellModel(at: IndexPath(row: 0, section: 0))
        XCTAssertNotNil(cellForRow)
    }
}
