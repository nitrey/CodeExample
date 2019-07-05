//
//  NetworkSessionMock.swift
//  Created by Alexander Antonov on 14/04/2019.
//

import Foundation
import XCTest
@testable import CurrencyRates

extension NetworkServiceTests {
    
    class NetworkSessionMock: NetworkSession {
        
        let data: Data?
        let response: URLResponse?
        let error: Error?
        
        init(data: Data?, response: URLResponse?, error: Error?) {
            self.data = data
            self.response = response
            self.error = error
        }
        
        func loadData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
            completion(data, response, error)
        }
    }
    
}
