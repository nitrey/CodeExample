//
//  URLSession+NetworkSession.swift
//  Created by Alexander Antonov on 12/04/2019.
//

import Foundation

extension URLSession: NetworkSession {
    
    func loadData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let task = dataTask(with: url) { (data, response, error) in
            completion(data, response, error)
        }
        task.resume()
    }
    
}
