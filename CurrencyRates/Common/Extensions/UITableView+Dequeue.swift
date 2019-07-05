//
//  UITableView+Dequeue.swift
//  Created by Alexander Antonov on 08/04/2019.
//

import UIKit.UITableView

extension UITableView {
    
    func dequeueReusableCell<Cell: UITableViewCell>(for indexPath: IndexPath) -> Cell {
        let identifier = Cell.identifier
        return dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! Cell
    }
    
}
