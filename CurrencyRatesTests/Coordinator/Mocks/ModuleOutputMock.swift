//
//  ModuleOutputMock.swift
//  Created by Alexander Antonov on 10/04/2019.
//

import XCTest
@testable import CurrencyRates

extension SelectCurrencyPairCoordinatorTests {
    
    class ModuleOutputMock: SelectCurrencyPairModuleOutput {
        
        var result: CurrencyPair?
        let expectation: XCTestExpectation
        
        init(expectation: XCTestExpectation) {
            self.expectation = expectation
        }
        
        func didSelect(_ currencyPair: CurrencyPair) {
            result = currencyPair
            expectation.fulfill()
        }
        
    }
    
}
