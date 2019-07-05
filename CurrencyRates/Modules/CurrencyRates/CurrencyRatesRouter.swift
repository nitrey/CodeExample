//
//  CurrencyRatesRouter.swift
//  Created by Alexander Antonov on 10/04/2019.
//

import Foundation

// MARK: - Protocol
protocol CurrencyRatesRouterInput {
    func showPairSelection(from currencies: [Currency], existing: Set<CurrencyPair>, output: SelectCurrencyPairModuleOutput)
}

// MARK: - Router
final class CurrencyRatesRouter: CurrencyRatesRouterInput {
    
    weak var view: TransitionHandler?
    
    private let factory = SelectCurrencyPairFactory()
    
    func showPairSelection(from currencies: [Currency], existing: Set<CurrencyPair>, output: SelectCurrencyPairModuleOutput) {
        let model = SelectCurrencyPairFactory.Model(currencies: currencies, existingPairs: existing, moduleOutput: output)
        let vc = factory.makeModule(from: model)
        view?.presentModule(vc, animated: true)
    }
    
}
