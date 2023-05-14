//
//  TestUtils.swift
//  PlanetsTests
//
//  Created by Gisonmon George on 14/05/23.
//

import Foundation

/*
 Test utility class for reading the files from resource
 */
class TestUtils {
   
    class func readLocalFile(forName name: String) -> Data? {
        do {
            guard let url = Bundle(for: PlanetsServiceMock.self).url(forResource: name, withExtension: "json") else {
                return nil
            }
            let jsonData = try String(contentsOfFile: url.path).data(using: .utf8)
            return jsonData
        } catch {
            print(error)
        }
        return nil
    }
}
