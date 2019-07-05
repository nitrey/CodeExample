//
//  ModuleFactory.swift
//  Created by Alexander Antonov on 13/04/2019.
//

protocol ModuleFactory {
    
    associatedtype Model
    
    func makeModule(from model: Model) -> TransitionHandler
}
