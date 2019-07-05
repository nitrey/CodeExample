//
//  UpdateAction.swift
//  Created by Alexander Antonov on 13/04/2019.
//

import Foundation

enum UpdateAction {
    case reload
    case updateVisibleCells
    case insertRow(at: IndexPath)
    case delete(at: IndexPath)
}
