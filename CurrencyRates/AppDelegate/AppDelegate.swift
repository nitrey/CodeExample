//
//  AppDelegate.swift
//  Created by Alexander Antonov on 08/04/2019.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private let startModuleFactory = CurrencyRatesFactory()

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupStartScreen()
        return true
    }
    
    private func setupStartScreen() {
        let model = CurrencyRatesFactory.Model(availableCurrencies: App.availableCurrencies)
        let vc = startModuleFactory.makeModule(from: model)
        let navController = UINavigationController(rootViewController: vc)
        navController.setSolid(color: Colors.whiteBackground)
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
    }

}
