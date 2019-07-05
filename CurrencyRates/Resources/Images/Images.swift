//
//  Images.swift
//  Created by Alexander Antonov on 13/04/2019.
//

import UIKit

enum Images {
    
    static let plusSign = UIImage(named: "plus")
    
    static func countryFlag(for currency: Currency) -> UIImage? {
        return UIImage(named: currency.rawValue)
    }
    
}
