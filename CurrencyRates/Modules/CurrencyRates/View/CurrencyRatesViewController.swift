//
//  CurrencyRatesViewController.swift
//  Created by Alexander Antonov on 10/04/2019.
//

import UIKit

protocol CurrencyRatesViewInput: AlertPresentable {
    func setup(with model: CurrencyRatesViewModel, action: UpdateAction)
}

final class CurrencyRatesViewController: UIViewController {
    
    // MARK: - Properties
    var presenter: CurrencyRatesPresenter?
    var alertView: ErrorAlertView?
    
    private let tableView = UITableView()
    private var viewModel: CurrencyRatesViewModel = CurrencyRatesViewModel(sections: [], isEmpty: true) {
        didSet {
            tableView.bounces = !viewModel.isEmpty
            tableView.isScrollEnabled = !viewModel.isEmpty
        }
    }

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Colors.whiteBackground
        tableView.backgroundColor = Colors.whiteBackground
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.bounces = false
        tableView.register(cellTypes: LargeAddCell.self, CompactAddCell.self, ConversionRateCell.self)
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        presenter?.viewDidLoad()
    }
    
}

// MARK: - UITableViewDataSource
extension CurrencyRatesViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.sections[section].numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch viewModel.sections[indexPath.section] {
            
        case .largeAddPair:
            let cell: LargeAddCell = tableView.dequeueReusableCell(for: indexPath)
            let model = LargeAddCell.Model(title: Texts.addCurrencyPairButton, description: Texts.addCurrencyPairDescription)
            cell.setup(with: model)
            cell.delegate = presenter
            return cell
            
        case .smallAddPair:
            let cell: CompactAddCell = tableView.dequeueReusableCell(for: indexPath)
            let model = CompactAddCell.Model(title: Texts.addCurrencyPairButton)
            cell.setup(with: model)
            cell.delegate = presenter
            return cell
            
        case .rates(let items):
            let cell: ConversionRateCell = tableView.dequeueReusableCell(for: indexPath)
            let item = items[indexPath.row]
            cell.setup(with: item)
            return cell
        }
    }
    
}

// MARK: - UITableViewDelegate
extension CurrencyRatesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight(in: tableView, at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight(in: tableView, at: indexPath)
    }
    
    private func cellHeight(in tableView: UITableView, at indexPath: IndexPath) -> CGFloat {
        switch viewModel.sections[indexPath.section] {
        case .largeAddPair:     return tableView.visibleSize.height
        case .smallAddPair:     return CompactAddCell.height
        case .rates:            return ConversionRateCell.height
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        guard case .rates = viewModel.sections[indexPath.section] else { return false }
        return true
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        guard case .rates(let items) = viewModel.sections[indexPath.section] else { return nil }
        let item = items[indexPath.row]
        return "DELETE \n\(item.pair.first.label) to \(item.pair.second.label)"
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let currencyPair = viewModel.items[indexPath.row].pair
        presenter?.delete(currencyPair, at: indexPath)
    }
    
}

// MARK: - CurrencyRatesViewInput
extension CurrencyRatesViewController: CurrencyRatesViewInput {
    
    func setup(with model: CurrencyRatesViewModel, action: UpdateAction) {
        dismissAlertIfExists()
        viewModel = model
        update(with: action)
    }
    
    private func update(with action: UpdateAction) {
        switch action {
        case .reload:
            tableView.contentOffset = .zero
            tableView.reloadData()
        case .updateVisibleCells:
            updateVisibleRatesCells()
        case .insertRow(let indexPath):
            tableView.insertRows(at: [indexPath], with: .automatic)
        case .delete(let indexPath):
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    private func updateVisibleRatesCells() {
        
        guard !viewModel.isEmpty else { return }
        let items = viewModel.items
        
        tableView.indexPathsForVisibleRows?.forEach {
            guard let cell = tableView.cellForRow(at: $0) as? ConversionRateCell else { return }
            cell.updateRate(with: items[$0.row].valueText)
        }
    }
    
}
