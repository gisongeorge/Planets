//
//  PlantsService.swift
//  Planets
//
//  Created by Gisonmon George on 12/05/23.
//

import Foundation

/*
 Protocol for getting planets data from API
 */
protocol PlanetsServiceProtocol {
    func getPlanets(url: String, completion: @escaping (_ planets: PlanetsModel?, _ error: ApiError?) -> ())
}

/*
 API Service class for getting the planets results
 It contains a apiHandler object, which is created by using dependency injection
 */
class PlanetsService: PlanetsServiceProtocol {
    
    private var apiHandler: ApiHandlerProtocol
    
    init(apiHandler: ApiHandlerProtocol) {
        self.apiHandler = apiHandler
    }
    
    // MARK: Get Planets API Call
    func getPlanets(url: String, completion: @escaping (PlanetsModel?, ApiError?) -> ()) {
        let url = URL(string: url)
        apiHandler.get(url: url, resultModel: PlanetsModel.self) { result in
            switch result {
            case .success(let planets):
                completion(planets, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}
