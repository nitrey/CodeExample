//
//  RouterMock.swift
//  Created by Alexander Antonov on 10/04/2019.
//

@testable import CurrencyRates

extension SelectCurrencyPairCoordinatorTests {
    
    class RouterMock: SelectCurrencyPairRouterInput {
        
        var view: ViewMock?
        var dismissCalled = false
        var showCurrencyScreenCalled = false
        
        func showCurrencySelectionScreen() {
            showCurrencyScreenCalled = true
            view?.show()
        }
        
        func dismissView(completion: (() -> Void)?) {
            dismissCalled = true
            completion?()
        }
        
    }
    
}
