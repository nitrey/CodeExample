//
//  CurrencyRatesFactory.swift
//  Created by Alexander Antonov on 10/04/2019.
//

import UIKit

final class CurrencyRatesFactory: ModuleFactory {
    
    struct Model {
        let availableCurrencies: [Currency]
    }
    
    func makeModule(from model: Model) -> TransitionHandler {
        
        let view = CurrencyRatesViewController()
                
        let modelBuilder = CurrencyRatesViewModelBuilderImp()
        let presenter = CurrencyRatesPresenter(availableCurrencies: model.availableCurrencies,
                                               modelBuilder: modelBuilder)
        
        let router = CurrencyRatesRouter()
        
        let session = URLSession(timeout: 5)
        let networkService = NetworkServiceImp(session: session)
        let ratesService = CurrencyRatesServiceImp(networkService: networkService)
        let pairsStorage = CurrencyPairsStorageImp()
        let interactor = CurrencyRatesInteractor(ratesService: ratesService, pairsStorage: pairsStorage)
        
        view.presenter = presenter
        view.title = Texts.ratesScreenName
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.presenter = presenter
        
        router.view = view
        
        return view
    }
    
}
