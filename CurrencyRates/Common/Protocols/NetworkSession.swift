//
//  NetworkSession.swift
//  Created by Alexander Antonov on 12/04/2019.
//

import Foundation

protocol NetworkSession {
    func loadData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Void)
}
