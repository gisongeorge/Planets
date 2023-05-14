//
//  PlanetsDBServiceTests.swift
//  PlanetsTests
//
//  Created by Gisonmon George on 14/05/23.
//

import XCTest
@testable import Planets

final class PlanetsDBServiceTests: XCTestCase {
    
    var planetsDBService: PlanetsDBService!
    
    override func setUp() {
        super.setUp()
        planetsDBService = PlanetsDBService(stack: CoreDataStackMock())
    }
    
    override func tearDown() {
        super.tearDown()
        planetsDBService = nil
    }
    
    func testSavePlanetsToDb() {
        planetsDBService.savePlanetsToDb(planets: nil, completion: {
            XCTAssertEqual(self.planetsDBService.loadPlanetsFromDb().count, 0)
        })
        
        let planets = planetsStubData()
        planetsDBService.savePlanetsToDb(planets: planets, completion: {
            let planets = self.planetsDBService.loadPlanetsFromDb()
            XCTAssertNotNil(planets)
            XCTAssertTrue(planets.count > 0)
        })
    }
    
    func testLoadPlanetsFromDb() {
        let allItems = planetsDBService.loadPlanetsFromDb()
        XCTAssertEqual(allItems.count, 0)
        
        let planets = planetsStubData()
        planetsDBService.savePlanetsToDb(planets: planets, completion: {
            let planets = self.planetsDBService.loadPlanetsFromDb()
            XCTAssertNotNil(planets)
            XCTAssertTrue(planets.count > 0)
        })
    }
    
    func testDeleteAllPlanets() {
        var planets = self.planetsDBService.loadPlanetsFromDb()
        XCTAssertEqual(planets.count, 0)
        
        let stubData = planetsStubData()
        planetsDBService.savePlanetsToDb(planets: stubData, completion: {
            planets = self.planetsDBService.loadPlanetsFromDb()
            XCTAssertNotNil(planets)
            XCTAssertTrue(planets.count > 0)
        })
        planetsDBService.deleteAllPlanets()
        planets = self.planetsDBService.loadPlanetsFromDb()
        XCTAssertEqual(planets.count, 0)
    }
}

extension PlanetsDBServiceTests {
    func planetsStubData() -> PlanetsModel? {
        var stubData: PlanetsModel?
        if let data = TestUtils.readLocalFile(forName: "PlanetsModelStub") {
            let decoder = JSONDecoder()
            if let json = try? decoder.decode(PlanetsModel.self, from: data) {
                stubData = json
            }
        }
        return stubData
    }
}
