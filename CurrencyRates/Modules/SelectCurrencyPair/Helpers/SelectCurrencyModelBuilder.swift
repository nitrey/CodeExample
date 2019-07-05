//
//  SelectCurrencyModelBuilder.swift
//  Created by Alexander Antonov on 09/04/2019.
//

import Foundation

// MARK: - Protocol
protocol SelectCurrencyModelBuilder {
    func buildModel(for step: SelectCurrencyPairStep) -> SelectCurrencyModel
}

// MARK: - Implementation
final class SelectCurrencyModelBuilderImp {
    
    // MARK: - Properties
    private let currencies: [Currency]
    private let checkupFactory: CurrencyCheckupFactory
    
    // MARK: - Init
    init(currencies: [Currency], checkupFactory: CurrencyCheckupFactory) {
        self.currencies = currencies
        self.checkupFactory = checkupFactory
    }
    
    // MARK: - Methods
    private func makeCheckup(for step: SelectCurrencyPairStep) -> CurrencyCheckup {
        
        switch step {
        case .requestingFirstCurrency:
            return checkupFactory.makeCheckup(for: .anyPossiblePairExist)
        case .requestingSecondCurrency(let first):
            let checkups: [CurrencyCheckup] = [
                checkupFactory.makeCheckup(for: .currenciesDontMatch(other: first)),
                checkupFactory.makeCheckup(for: .pairDoesntExist(first: first)),
            ]
            return checkupFactory.reduce(checkups)
        }
    }
    
}

// MARK: - SelectCurrencyModelBuilder
extension SelectCurrencyModelBuilderImp: SelectCurrencyModelBuilder {
    
    func buildModel(for step: SelectCurrencyPairStep) -> SelectCurrencyModel {
        let availabilityCheckup = makeCheckup(for: step)
        let items: [CurrencyItem] = currencies.map {
            let isAvailable = availabilityCheckup($0)
            return CurrencyItem(currency: $0, isActive: isAvailable)
        }
        return SelectCurrencyModel(items: items)
    }
    
}
