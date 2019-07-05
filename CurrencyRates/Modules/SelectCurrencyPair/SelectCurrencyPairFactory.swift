//
//  SelectCurrencyPairFactory.swift
//  Created by Alexander Antonov on 09/04/2019.
//

import UIKit

// MARK: - Module Output Protocol
protocol SelectCurrencyPairModuleOutput: AnyObject {
    func didSelect(_ currencyPair: CurrencyPair)
}

// MARK: - Factory Implementation
final class SelectCurrencyPairFactory {
    
    struct Model {
        let currencies: [Currency]
        let existingPairs: Set<CurrencyPair>
        let moduleOutput: SelectCurrencyPairModuleOutput
    }
    
    func makeModule(from model: Model) -> UIViewController {
        
        let checkupFactory = CurrencyCheckupFactoryImp(currencies: model.currencies, existingPairs: model.existingPairs)
        let modelBuilder = SelectCurrencyModelBuilderImp(currencies: model.currencies, checkupFactory: checkupFactory)
        let coordinator = SelectCurrencyPairCoordinator(modelBuilder: modelBuilder)
        
        let navController = UINavigationController()
        navController.navigationItem.leftBarButtonItem = nil
        navController.isNavigationBarHidden = true
        let router = SelectCurrencyPairRouter(navController: navController, viewOutput: coordinator)
        
        coordinator.router = router
        coordinator.moduleOutput = model.moduleOutput
        coordinator.start()
        
        return navController
    }
    
}
