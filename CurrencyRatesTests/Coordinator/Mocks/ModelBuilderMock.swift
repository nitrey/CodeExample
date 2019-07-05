//
//  ModelBuilderMock.swift
//  Created by Alexander Antonov on 10/04/2019.
//

@testable import CurrencyRates

extension SelectCurrencyPairCoordinatorTests {
    
    class ModelBuilderMock: SelectCurrencyModelBuilder {
        
        var buildModelCalled = false
        
        func buildModel(for step: SelectCurrencyPairStep) -> SelectCurrencyModel {
            buildModelCalled = true
            return SelectCurrencyModel(items: [])
        }
        
    }
    
}
