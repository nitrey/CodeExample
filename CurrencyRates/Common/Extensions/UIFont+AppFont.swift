//
//  UIFont+AppFont.swift
//  Created by Alexander Antonov on 13/04/2019.
//

import UIKit.UIFont

extension UIFont {
    
    enum FontType {
        case robotoRegular(size: CGFloat)
        case robotoMedium(size: CGFloat)
    }
    
    static func appFont(_ type: FontType) -> UIFont {
        switch type {
        case .robotoRegular(let size):      return UIFont(name: "Roboto-Regular", size: size)!
        case .robotoMedium(size: let size): return UIFont(name: "Roboto-Medium", size: size)!
        }
    }
    
}
