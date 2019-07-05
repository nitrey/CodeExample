//
//  TransitionHandler.swift
//  Created by Alexander Antonov on 13/04/2019.
//

import UIKit

protocol TransitionHandler where Self: UIViewController {
    
    func presentModule(_ view: TransitionHandler, animated: Bool, completion: (() -> Void)?)
    func presentModule(_ view: TransitionHandler, animated: Bool)
    
    func pushModule(_ view: TransitionHandler, animated: Bool, completion: (() -> Void)?)
    func pushModule(_ view: TransitionHandler, animated: Bool)
    
    func dismissModule(animated: Bool, completion: (() -> Void)?)
}

extension UIViewController: TransitionHandler {
    
    func presentModule(_ view: TransitionHandler, animated: Bool, completion: (() -> Void)?) {
        present(view, animated: animated, completion: completion)
    }
    
    func presentModule(_ view: TransitionHandler, animated: Bool) {
        present(view, animated: animated, completion: nil)
    }
    
    func pushModule(_ view: TransitionHandler, animated: Bool, completion: (() -> Void)?) {
        navigationController?.pushModule(view, animated: animated, completion: completion)
    }
    func pushModule(_ view: TransitionHandler, animated: Bool) {
        navigationController?.pushModule(view, animated: animated, completion: nil)
    }
    
    func dismissModule(animated: Bool, completion: (() -> Void)?) {
        dismiss(animated: animated, completion: completion)
    }
    
}
