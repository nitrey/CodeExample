//
//  UITableViewCell+Identifier.swift
//  Created by Alexander Antonov on 08/04/2019.
//

import UIKit.UITableViewCell

extension UITableViewCell {
    
    static var identifier: String {
        return String(describing: self)
    }
    
}
