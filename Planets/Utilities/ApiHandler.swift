//
//  ApiManager.swift
//  Planets
//
//  Created by Gisonmon George on 12/05/23.
//

import Foundation

// Custom error to be used in api call and parsing
enum ApiError: Error {
    case urlFailed
    case noData
    case requestError
    case parsingFailed
}

protocol ApiHandlerProtocol {
    func get<T: Decodable>(url: URL?, resultModel: T.Type, completion: @escaping((Result<T, ApiError>)->Void))
}

/*
 Singleton utility class for handling API calls
 Using URLSession to manage the dataTask
 */
class ApiHandler: ApiHandlerProtocol {
    
    public static let shared = ApiHandler()
    
    // MARK: Get API Call
    func get<T: Decodable>(url: URL?, resultModel: T.Type, completion: @escaping((Result<T, ApiError>)->Void)) {
        guard let url = url else {
            return completion(.failure(.urlFailed))
        }

        let session = URLSession.shared
        let task: URLSessionDataTask = session.dataTask(with: url, completionHandler: { data, _, error in

            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    completion(.failure(.noData))
                    return
                }
                let decoder = JSONDecoder()
                if let json = try? decoder.decode(T.self, from: data) {
                    completion(.success(json))
                } else {
                    completion(.failure(.parsingFailed))
                }
            }
        })
        task.resume()
    }
}
