//
//  CurrencyRatesInteractor.swift
//  Created by Alexander Antonov on 10/04/2019.
//

// MARK: - Protocol
protocol CurrencyRatesInteractorInput {
    func fetchExistingCurrencyPairs() throws -> [CurrencyPair]
    func saveNew(_ currencyPair: CurrencyPair)
    func delete(_ currencyPair: CurrencyPair)
    func obtainRates(for pairs: [CurrencyPair])
}

// MARK: - Interactor
final class CurrencyRatesInteractor {
    
    weak var presenter: CurrencyRatesInteractorOutput?
    
    private let ratesService: CurrencyRatesService
    private let pairsStorage: CurrencyPairsStorage
    
    init(ratesService: CurrencyRatesService, pairsStorage: CurrencyPairsStorage) {
        self.ratesService = ratesService
        self.pairsStorage = pairsStorage
    }
    
}

// MARK: - CurrencyRatesInteractorInput
extension CurrencyRatesInteractor: CurrencyRatesInteractorInput {
    
    func fetchExistingCurrencyPairs() throws -> [CurrencyPair] {
        return try pairsStorage.fetchExistingCurrencyPairs()
    }
    
    func saveNew(_ currencyPair: CurrencyPair) {
        pairsStorage.saveNew(currencyPair)
    }
    
    func delete(_ currencyPair: CurrencyPair) {
        pairsStorage.delete(currencyPair)
    }
    
    func obtainRates(for pairs: [CurrencyPair]) {
        
        guard pairs.isNotEmpty else { return }
        
        ratesService.obtainRates(for: pairs) { [weak self] result in
            
            switch result {
            case .success(let response):
                self?.presenter?.didObtainCurrencyRates(response.rates)
            case .failure(let error):
                self?.presenter?.didFailToObtainCurrencyRates(with: error)
            }
        }
    }
    
}
