//
//  NetworkServiceMock.swift
//  Created by Alexander Antonov on 14/04/2019.
//

import Foundation
@testable import CurrencyRates

final class NetworkServiceMock: NetworkService {
    
    let result: NetworkResult
    
    init(result: NetworkResult) {
        self.result = result
    }
    
    func performRequest(url: URL, completion: @escaping (NetworkResult) -> Void) {
        completion(result)
    }
    
}
