//
//  CurrencyRatesPresenter.swift
//  Created by Alexander Antonov on 10/04/2019.
//

import Foundation

// MARK: - Protocols
protocol CurrencyRatesViewOutput: ViewOutput, AddActionDelegate {
    func delete(_ currencyPair: CurrencyPair, at indexPath: IndexPath)
}

protocol CurrencyRatesInteractorOutput: AnyObject {
    func didObtainCurrencyRates(_ rates: [CurrencyPair: Decimal])
    func didFailToObtainCurrencyRates(with error: APIError)
}

// MARK: - Presenter
final class CurrencyRatesPresenter {
    
    // MARK: - Public properties
    weak var view: CurrencyRatesViewInput?
    var interactor: CurrencyRatesInteractorInput?
    var router: CurrencyRatesRouter?
    
    // MARK: - Private properties
    private let availableCurrencies: [Currency]
    private let modelBuilder: CurrencyRatesViewModelBuilder
    private var currencyPairs: [CurrencyPair] = []
    private var viewModel = CurrencyRatesViewModel(sections: [], isEmpty: true)
    private var timer: Timer?
    
    // MARK: - Init
    init(availableCurrencies: [Currency], modelBuilder: CurrencyRatesViewModelBuilder) {
        self.availableCurrencies = availableCurrencies
        self.modelBuilder = modelBuilder
    }
    
    // MARK: - Deinit
    deinit {
        stopTimer()
    }
    
    // MARK: - Private methods
    private func requestCurrencyRates() {
        interactor?.obtainRates(for: currencyPairs)
    }
    
    private func setupRatesUpdateTimer() {
        stopTimer()
        guard currencyPairs.isNotEmpty else { return }
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            self?.requestCurrencyRates()
        }
        timer?.fire()
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
}

// MARK: - CurrencyRatesViewOutput
extension CurrencyRatesPresenter: CurrencyRatesViewOutput {
    
    func viewDidLoad() {
        guard let interactor = interactor else { return }
        do {
            currencyPairs = try interactor.fetchExistingCurrencyPairs()
            let items: [ConversionRateItem] = currencyPairs.map { ConversionRateItem(pair: $0, value: nil) }
            viewModel = modelBuilder.viewModel(with: items)
            view?.setup(with: viewModel, action: .reload)
            setupRatesUpdateTimer()
        } catch {
            view?.presentAlert(with: Texts.databaseError)
        }
    }
    
    func didTapAdd() {
        let existingPairsSet = Set(currencyPairs)
        router?.showPairSelection(from: availableCurrencies, existing: existingPairsSet, output: self)
    }
    
    func delete(_ currencyPair: CurrencyPair, at indexPath: IndexPath) {
        currencyPairs.remove(at: indexPath.row)
        interactor?.delete(currencyPair)
        let (newModel, action) = modelBuilder.updateModelDeleting(in: viewModel, at: indexPath)
        viewModel = newModel
        view?.setup(with: viewModel, action: action)
        setupRatesUpdateTimer()
    }
    
}

// MARK: - CurrencyRatesInteractorOutput
extension CurrencyRatesPresenter: CurrencyRatesInteractorOutput {
    
    func didObtainCurrencyRates(_ rates: [CurrencyPair: Decimal]) {
        viewModel = modelBuilder.update(viewModel, with: rates)
        view?.setup(with: viewModel, action: .updateVisibleCells)
    }
    
    func didFailToObtainCurrencyRates(with error: APIError) {
        view?.presentAlert(with: Texts.connectionError)
    }
    
}

// MARK: - SelectCurrencyPairModuleOutput
extension CurrencyRatesPresenter: SelectCurrencyPairModuleOutput {
    
    func didSelect(_ currencyPair: CurrencyPair) {
        currencyPairs.insert(currencyPair, at: 0)
        setupRatesUpdateTimer()
        updateViewWithInserting(of: currencyPair)
        interactor?.saveNew(currencyPair)
    }
    
    private func updateViewWithInserting(of currencyPair: CurrencyPair) {
        let (newModel, action) = modelBuilder.updateModelInserting(in: viewModel, newPair: currencyPair)
        viewModel = newModel
        view?.setup(with: newModel, action: action)
    }
    
}
