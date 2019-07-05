//
//  ViewMock.swift
//  Created by Alexander Antonov on 10/04/2019.
//

@testable import CurrencyRates

extension SelectCurrencyPairCoordinatorTests {
    
    class ViewMock: SelectCurrencyPairViewInput {
        
        var timesCalled = 0
        weak var output: SelectCurrencyViewOutput?
        
        private let first: Currency
        private let second: Currency
        
        init(first: Currency, second: Currency) {
            self.first = first
            self.second = second
        }
        
        func show() {
            output?.viewDidLoad()
        }
        
        func setup(with model: SelectCurrencyModel) {
            
            let times = timesCalled
            timesCalled += 1
            
            switch times {
            case 0:     output?.didSelect(first)
            case 1:     output?.didSelect(second)
            default:    break
            }
        }
        
    }
    
}
