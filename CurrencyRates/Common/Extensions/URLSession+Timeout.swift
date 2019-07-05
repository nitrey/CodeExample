//
//  URLSession+Timeout.swift
//  Created by Alexander Antonov on 14/04/2019.
//

import Foundation

extension URLSession {
    
    convenience init(timeout: TimeInterval) {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = timeout
        self.init(configuration: configuration)
    }
    
}
