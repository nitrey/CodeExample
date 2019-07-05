//
//  CurrencyRatesViewModelBuilder.swift
//  Created by Alexander Antonov on 13/04/2019.
//

import Foundation

protocol CurrencyRatesViewModelBuilder {
        
    func viewModel(with items: [ConversionRateItem]) -> CurrencyRatesViewModel
    
    func update(_ oldModel: CurrencyRatesViewModel,
                with rates: [CurrencyPair: Decimal]) -> CurrencyRatesViewModel
    
    func updateModelInserting(in oldModel: CurrencyRatesViewModel,
                              newPair: CurrencyPair) -> (CurrencyRatesViewModel, UpdateAction)
    
    func updateModelDeleting(in oldModel: CurrencyRatesViewModel,
                             at indexPath: IndexPath) -> (CurrencyRatesViewModel, UpdateAction)
}

final class CurrencyRatesViewModelBuilderImp: CurrencyRatesViewModelBuilder {
    
    // MARK: - Typealias
    private typealias ViewModel = CurrencyRatesViewModel
    private typealias Section = CurrencyRatesViewModel.Section
    private typealias CellModel = ConversionRateCell.Model
    
    // MARK: - Private properties
    private let emptyModel = CurrencyRatesViewModel(sections: [.largeAddPair], isEmpty: true)
    private let valueConverter: DecimalNumberConverter
    
    // MARK: - Init
    init(valueConverter: DecimalNumberConverter = DecimalNumberConverterImp()) {
        self.valueConverter = valueConverter
    }
    
    // MARK: - Public
    func viewModel(with items: [ConversionRateItem]) -> CurrencyRatesViewModel {
        let cellModels = items.map { createCellModels(for: $0) }
        return viewModel(with: cellModels)
    }
    
    func update(_ oldModel: CurrencyRatesViewModel,
                with rates: [CurrencyPair: Decimal]) -> CurrencyRatesViewModel {
        
        guard !oldModel.isEmpty else { return oldModel }
        var sections: [Section] = []
        
        for section in oldModel.sections {
            switch section {
            case .largeAddPair, .smallAddPair:
                sections.append(section)
            case .rates(let items):
                let updated = updatedRatesSection(items: items, rates: rates)
                sections.append(updated)
            }
        }
        return ViewModel(sections: sections, isEmpty: false)
    }
    
    func updateModelInserting(in oldModel: CurrencyRatesViewModel,
                              newPair: CurrencyPair) -> (CurrencyRatesViewModel, UpdateAction) {
        
        let newCellModel = CellModel(pair: newPair, valueText: nil)
        let cellModels = [newCellModel] + oldModel.items
        let newModel = viewModel(with: cellModels)
        let action: UpdateAction
        
        if let sectionIndex = oldModel.ratesSectionIndex {
            action = .insertRow(at: IndexPath(row: 0, section: sectionIndex))
        } else {
            action = .reload
        }
        return (newModel, action)
    }
    
    func updateModelDeleting(in oldModel: CurrencyRatesViewModel,
                             at indexPath: IndexPath) -> (CurrencyRatesViewModel, UpdateAction) {
        
        var cellModels = oldModel.items
        cellModels.remove(at: indexPath.row)
        let newModel = viewModel(with: cellModels)
        let action: UpdateAction = newModel.isEmpty ? .reload : .delete(at: indexPath)
        return (newModel, action)
    }
    
    // MARK: - Private
    private func viewModel(with cellModels: [CellModel]) -> ViewModel {
        guard cellModels.isNotEmpty else { return emptyModel }
        let sections: [Section] = [.smallAddPair, .rates(cellModels)]
        return ViewModel(sections: sections, isEmpty: false)
    }
    
    private func updatedRatesSection(items: [CellModel], rates: [CurrencyPair: Decimal?]) -> Section {
        let cellModels: [CellModel] = items.map { item in
            let rate = rates[item.pair] ?? nil
            let updatedValueText = valueConverter.valueText(for: rate) ?? item.valueText
            return CellModel(pair: item.pair, valueText: updatedValueText)
        }
        return Section.rates(cellModels)
    }
    
    private func createCellModels(for item: ConversionRateItem) -> ConversionRateCell.Model {
        let value = valueConverter.valueText(for: item.value)
        return CellModel(pair: item.pair, valueText: value)
    }
    
}
