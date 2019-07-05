//
//  ViewOutput.swift
//  Created by Alexander Antonov on 09/04/2019.
//

protocol ViewOutput: AnyObject {
    
    func viewDidLoad()
    func viewWillAppear()
    func viewWillDisappear()
}

// Default Implementation
extension ViewOutput {
    
    func viewDidLoad() { }
    func viewWillAppear() { }
    func viewWillDisappear() { }
}
