//
//  SelectCurrencyPairViewController.swift
//  Created by Alexander Antonov on 08/04/2019.
//

import UIKit

// MARK: - View Input Protocol
protocol SelectCurrencyPairViewInput: AnyObject {
    func setup(with model: SelectCurrencyModel)
}

// MARK: - View Implementation
final class SelectCurrencyViewController: UIViewController {
    
    // MARK: - Properties
    var output: SelectCurrencyViewOutput?
    private var model: SelectCurrencyModel?
    private let tableView = UITableView()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        output?.viewDidLoad()
    }
    
    // MARK: - UI
    private func configureUI() {
        
        view.backgroundColor = Colors.whiteBackground
        
        tableView.backgroundColor = Colors.whiteBackground
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.estimatedRowHeight = CurrencyCell.height
        tableView.rowHeight = CurrencyCell.height
        tableView.register(CurrencyCell.self, forCellReuseIdentifier: CurrencyCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
}

// MARK: - UITableViewDataSource
extension SelectCurrencyViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model?.items.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let model = model else { return UITableViewCell() }
        let cell: CurrencyCell = tableView.dequeueReusableCell(for: indexPath)
        let item = model.items[indexPath.row]
        cell.setup(with: item)
        return cell
    }
    
}

// MARK: - UITableViewDelegate
extension SelectCurrencyViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let item = model?.items[indexPath.row], item.isActive else {
            tableView.deselectRow(at: indexPath, animated: false)
            return
        }
        tableView.isUserInteractionEnabled = false
        output?.didSelect(item.currency)
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return model?.items[indexPath.row].isActive ?? false
    }
    
}

// MARK: - SelectCurrencyPairViewInput
extension SelectCurrencyViewController: SelectCurrencyPairViewInput {
    
    func setup(with model: SelectCurrencyModel) {
        self.model = model
        tableView.reloadData()
    }
    
}
