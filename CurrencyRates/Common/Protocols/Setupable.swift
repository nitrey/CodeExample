//
//  Setupable.swift
//  Created by Alexander Antonov on 08/04/2019.
//

protocol Setupable {
    
    associatedtype Model
    
    func setup(with model: Model)
}
