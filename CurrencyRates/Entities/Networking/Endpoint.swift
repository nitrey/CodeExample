//
//  Endpoint.swift
//  Created by Alexander Antonov on 12/04/2019.
//

import Foundation

struct Endpoint {
    let destination: String
    let queryItems: [URLQueryItem]
}

extension Endpoint {
    
    var url: URL? {
        var components = URLComponents(string: destination)
        components?.queryItems = queryItems
        return components?.url
    }
    
}
