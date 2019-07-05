//
//  ErrorAlertView.swift
//  Created by Alexander Antonov on 13/04/2019.
//

import UIKit

private enum Locals {
    
    static let xOffset: CGFloat = 16
    static let boundsOffset: CGFloat = 20
    static let alertHeight: CGFloat = 60
    static let cornerRadius: CGFloat = 10
    static let background = #colorLiteral(red: 0.9331086278, green: 0, blue: 0, alpha: 0.55)
    static let messageFont = UIFont.appFont(.robotoMedium(size: 18))
    static let messageColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
}

final class ErrorAlertView: UIView {
    
    static var size: CGSize {
        let width = UIScreen.main.bounds.width - 2 * L.boundsOffset
        return CGSize(width: width, height: L.alertHeight)
    }
        
    private typealias L = Locals
    
    private let messageLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        drawSelf()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        drawSelf()
    }
    
    private func drawSelf() {
        
        backgroundColor = L.background
        layer.cornerRadius = L.cornerRadius
        layer.masksToBounds = true
        
        messageLabel.textAlignment = .center
        messageLabel.numberOfLines = 3
        messageLabel.font = L.messageFont
        messageLabel.textColor = L.messageColor
        addSubview(messageLabel)
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: L.xOffset),
            messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -L.xOffset),
            messageLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
}

// MARK: - Setupable
extension ErrorAlertView: Setupable {
    
    func setup(with model: String) {
        messageLabel.text = model
    }
    
}
