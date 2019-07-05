//
//  UINavigationController+Solid.swift
//  Created by Alexander Antonov on 14/04/2019.
//

import UIKit.UINavigationController

extension UINavigationController {
    
    func setSolid(color: UIColor) {
        navigationBar.isTranslucent = false
        navigationBar.barTintColor = color
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
    }
    
}
