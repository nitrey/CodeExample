//
//  SelectCurrencyPairRouter.swift
//  Created by Alexander Antonov on 09/04/2019.
//

import UIKit

// MARK: - Router Protocol
protocol SelectCurrencyPairRouterInput {
    func showCurrencySelectionScreen()
    func dismissView(completion: (() -> Void)?)
}

// MARK: - Router Implementation
final class SelectCurrencyPairRouter {
    
    private weak var navController: UINavigationController?
    private weak var viewOutput: SelectCurrencyViewOutput?
    private var hasAlreadyPushed = false
    
    init(navController: UINavigationController, viewOutput: SelectCurrencyViewOutput) {
        self.navController = navController
        self.viewOutput = viewOutput
    }
    
}

// MARK: - SelectCurrencyPairRouterInput
extension SelectCurrencyPairRouter: SelectCurrencyPairRouterInput {
    
    func showCurrencySelectionScreen() {
        let view = SelectCurrencyViewController()
        view.output = viewOutput
        viewOutput?.view = view
        navController?.pushViewController(view, animated: hasAlreadyPushed)
        hasAlreadyPushed = true
    }

    func dismissView(completion: (() -> Void)?) {
        navController?.dismiss(animated: true, completion: completion)
    }
    
}
