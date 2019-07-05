//
//  NetworkService.swift
//  Created by Alexander Antonov on 11/04/2019.
//

import Foundation

// MARK: - Result type
typealias NetworkResult = Result<Data, NetworkError>

// MARK: - Protocol
protocol NetworkService {
    func performRequest(url: URL, completion: @escaping (NetworkResult) -> Void)
}

// MARK: - Implementation
final class NetworkServiceImp: NetworkService {
    
    private let session: NetworkSession
    
    init(session: NetworkSession = URLSession.shared) {
        self.session = session
    }
    
    func performRequest(url: URL, completion: @escaping (NetworkResult) -> Void) {
        
        session.loadData(from: url) { (data, response, error) in
            
            let result: NetworkResult
            defer {
                DispatchQueue.main.async {
                    completion(result)
                }
            }
            guard error == nil,
                let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode == 200, // just for test case 
                let data = data
            else {
                result = .failure(.unknown)
                return
            }
            result = .success(data)
        }
        
    }
    
}
