//
//  UITableView+Registration.swift
//  Created by Alexander Antonov on 13/04/2019.
//

import UIKit.UITableView

extension UITableView {
    
    func register(cellTypes: UITableViewCell.Type...) {
        for cellType in cellTypes {
            register(cellType, forCellReuseIdentifier: cellType.identifier)
        }
    }
    
}
