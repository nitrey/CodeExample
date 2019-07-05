//
//  AlertPresentable.swift
//  Created by Alexander Antonov on 13/04/2019.
//

import UIKit

protocol AlertPresentable: AnyObject {
    
    var alertView: ErrorAlertView? { get set }
    
    func presentAlert(with message: String)
    func dismissAlertIfExists()
}

extension AlertPresentable where Self: UIViewController {
    
    func presentAlert(with message: String) {
        guard alertView == nil else { return }
        let alert = ErrorAlertView()
        alert.setup(with: message)
        view.addSubview(alert)
        alert.bounds.size = ErrorAlertView.size
        let bounds = view.bounds
        let targetY = bounds.maxY - 40 - (alert.bounds.height / 2)
        let distance: CGFloat = 120
        alert.center = CGPoint(x: bounds.midX, y: targetY + distance)
        UIView.animate(withDuration: 0.25, delay: 0, options: [.curveEaseOut], animations: {
            alert.center.y = targetY
        }, completion: nil)
        alertView = alert
    }
    
    func dismissAlertIfExists() {
        guard let alert = alertView else { return }
        UIView.animate(withDuration: 0.25, delay: 0, options: [.curveEaseIn], animations: {
            alert.center.y += 120
            alert.alpha = 0
        }, completion: { _ in
            alert.removeFromSuperview()
            self.alertView = nil
        })
    }
    
}
