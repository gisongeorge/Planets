//
//  PlanetsViewModel.swift
//  Planets
//
//  Created by Gisonmon George on 12/05/23.
//

import Foundation

/*
 View model to handle data request from view controller
 It contains planetsService, planetsDBService objects, which is created by using dependency injection
 A refreshUI tuple for updating the UI
 A array to keep planetsResults to load in the view
 */
class PlanetsViewModel {
    
    private var planetsService: PlanetsServiceProtocol
    private var planetsDBService: PlanetsDBServiceProtocol
    
    private var endPoint: String? = ApiEndPoints.planets
    private var isInitialLoad = true
    
    var planetsResults = [PlanetsCellViewModel]()

    var refreshUI: ((_ refreshMessage: String?) -> Void)?

    init(planetsService: PlanetsServiceProtocol, planetsDBService: PlanetsDBServiceProtocol) {
        self.planetsService = planetsService
        self.planetsDBService = planetsDBService
    }
    
    // MARK: Planets API Call
    func getPlanets(completion: @escaping() -> Void) {
        
        let planetsResults = planetsDBService.loadPlanetsFromDb()
        if planetsResults.count > 0 && isInitialLoad {
            self.planetsResults = planetsResults
            self.refreshUI?(nil)
        }
        if let endPoint {
            self.planetsService.getPlanets(url: endPoint) { [weak self] planets, apiError in
                if let apiError = apiError {
                    print("Error with API: \(apiError)")
                    self?.refreshUI?(Messages.apiError)
                    completion()
                    return
                }
                self?.processData(planets: planets)
                completion()
            }
        } else {
            print("All data loaded. Next page is not available")
            completion()
        }
        
    }
    
    // MARK: API Response processing
    
    // Processing the api result response and creating the cell models
    // Delete all plants records from DB
    // Save the API results to DB
    // Fetch the saved data from DB
    // Notify the view controller for data binding
    // Capable for handling paginations
    private func processData(planets: PlanetsModel?) {
        if let planets {
            endPoint = planets.next
            isInitialLoad = planets.previous == nil
            if isInitialLoad {
                planetsDBService.deleteAllPlanets()
            }
            planetsDBService.savePlanetsToDb(planets: planets) { [weak self] in
                guard let self = self else { return }
                let planetsResults = self.planetsDBService.loadPlanetsFromDb()
                if planetsResults.count > 0 {
                    self.planetsResults = planetsResults
                    self.refreshUI?(nil)
                } else {
                    self.refreshUI?(Messages.noResultFound)
                }
            }
        } else {
            refreshUI?(Messages.noResultFound)
        }
    }
    
    // MARK: Cell View Model
    
    // Return the number of results to be shown
    func numberOfRows() -> Int {
        return planetsResults.count
    }
    
    // Return the planet model for the corresponding cell based on the indexPath
    func getPlanetsCellModel(at indexPath: IndexPath) -> PlanetsCellViewModel {
        return planetsResults[indexPath.row]
    }
}
