//
//  SelectCurrencyPairCoordinator.swift
//  Created by Alexander Antonov on 09/04/2019.
//

import UIKit

// MARK: - View output protocol
protocol SelectCurrencyViewOutput: ViewOutput {
    var view: SelectCurrencyPairViewInput? { get set }
    func didSelect(_ currency: Currency)
}

// MARK: - Coordinator step enum
enum SelectCurrencyPairStep {
    case requestingFirstCurrency
    case requestingSecondCurrency(first: Currency)
}

// MARK: - Coordinator Implementation
final class SelectCurrencyPairCoordinator: Coordinator {
    
    // MARK: - Public properties
    weak var moduleOutput: SelectCurrencyPairModuleOutput?
    weak var view: SelectCurrencyPairViewInput?
    var router: SelectCurrencyPairRouterInput?
    
    // MARK: - Private properties
    private var currentStep: SelectCurrencyPairStep = .requestingFirstCurrency
    private let modelBuilder: SelectCurrencyModelBuilder
    
    // MARK: - Init
    init(modelBuilder: SelectCurrencyModelBuilder) {
        self.modelBuilder = modelBuilder
    }
    
    // MARK: - Public methods
    func start() {
        router?.showCurrencySelectionScreen()
    }
    
}

// MARK: - SelectCurrencyViewOutput
extension SelectCurrencyPairCoordinator: SelectCurrencyViewOutput {
    
    func viewDidLoad() {
        DispatchQueue.global(qos: .userInitiated).async {
            let model = self.modelBuilder.buildModel(for: self.currentStep)
            
            DispatchQueue.main.async {
                self.view?.setup(with: model)
            }
        }
    }
    
    func didSelect(_ currency: Currency) {
        
        switch currentStep {
            
        case .requestingFirstCurrency:
            currentStep = .requestingSecondCurrency(first: currency)
            router?.showCurrencySelectionScreen()
            
        case .requestingSecondCurrency(let first):
            let currencyPair = CurrencyPair(first: first, second: currency)
            router?.dismissView() {
                self.moduleOutput?.didSelect(currencyPair)
            }
        }
    }
    
}
