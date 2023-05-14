//
//  ApiHandlerMock.swift
//  PlanetsTests
//
//  Created by Gisonmon George on 14/05/23.
//

import Foundation
@testable import Planets

/*
 API handler mock class created to inject to test cases
 */
class ApiHandlerMock: ApiHandlerProtocol {
    
    func get<T>(url: URL?, resultModel: T.Type, completion: @escaping ((Result<T, Planets.ApiError>) -> Void)) where T : Decodable {
        if let data = TestUtils.readLocalFile(forName: "PlanetsModelStub") {
            let decoder = JSONDecoder()
            if let json = try? decoder.decode(T.self, from: data), let _ = url {
                completion(.success(json))
            } else {
                completion(.failure(.parsingFailed))
            }
        }
    }
}
