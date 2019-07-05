//
//  CurrencyCheckupFactory.swift
//  Created by Alexander Antonov on 09/04/2019.
//

// MARK: - Factory Protocol
protocol CurrencyCheckupFactory {
    func makeCheckup(for type: CurrencyCheckupType) -> CurrencyCheckup
    func reduce(_ checkups: [CurrencyCheckup]) -> CurrencyCheckup
}

// MARK: - Factory Implementation
final class CurrencyCheckupFactoryImp {
    
    // MARK: - Properties
    private let currencies: [Currency]
    private let existingPairs: Set<CurrencyPair>
    
    // MARK: - Init
    init(currencies: [Currency], existingPairs: Set<CurrencyPair>) {
        self.currencies = currencies
        self.existingPairs = existingPairs
    }
    
    // MARK: - Private methods
    private func makeCheckupPair(with firstCurrency: Currency, doesntExistIn existingPairs: Set<CurrencyPair>) -> CurrencyCheckup {
        return { currency in
            let pair = CurrencyPair(first: firstCurrency, second: currency)
            return !existingPairs.contains(pair)
        }
    }
    
    private func makeCheckupAnyPossiblePairsExist(besides existingPairs: Set<CurrencyPair>, totalCurrencies: Int) -> CurrencyCheckup {
        
        var cacheTable: [Currency: Int] = [:]
        
        return { currency in
            
            if let count = cacheTable[currency] {
                return count < totalCurrencies - 1
            } else {
                let count = existingPairs
                    .filter { $0.first == currency }
                    .count
                cacheTable[currency] = count
                return count < totalCurrencies - 1
            }
        }
        
    }
    
    private func makeCheckupCurrencyDoesntMatch(with otherCurrency: Currency) -> CurrencyCheckup {
        return { currency in
            return currency != otherCurrency
        }
    }
    
}

// MARK: - CurrencyCheckupFactory
extension CurrencyCheckupFactoryImp: CurrencyCheckupFactory {
    
    func makeCheckup(for type: CurrencyCheckupType) -> CurrencyCheckup {
        
        switch type {
        case .currenciesDontMatch(let otherCurrency):
            return makeCheckupCurrencyDoesntMatch(with: otherCurrency)
        case .anyPossiblePairExist:
            return makeCheckupAnyPossiblePairsExist(besides: existingPairs, totalCurrencies: currencies.count)
        case .pairDoesntExist(let firstCurrency):
            return makeCheckupPair(with: firstCurrency, doesntExistIn: existingPairs)
        }
    }
    
    func reduce(_ checkups: [CurrencyCheckup]) -> CurrencyCheckup {
        
        return { currency in
            for checkup in checkups {
                let isValid = checkup(currency)
                if isValid { continue } else { return false }
            }
            return true
        }
    }
    
}
