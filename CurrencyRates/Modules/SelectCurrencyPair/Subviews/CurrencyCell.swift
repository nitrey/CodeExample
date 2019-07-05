//
//  CurrencyCell.swift
//  Created by Alexander Antonov on 08/04/2019.
//

import UIKit

private enum Locals {
    
    static let height: CGFloat = 56
    static let inactiveAlpha: CGFloat = 0.5
    static let backgroundColor = Colors.whiteBackground
    
    // Icon of flag related to currency
    enum Icon {
        static let leading: CGFloat = 16
        static let size = CGSize(width: 24, height: 24)
    }
    
    // Currency Label (e.g. "USD")
    enum Label {
        static let leading: CGFloat = 56
        static let minTrailing: CGFloat = 10
        static let font = Fonts.robotoRegular16
        static let color = Colors.textGray
    }
    
    // Currency Name (e.g. "Norwegian Krone")
    enum Name {
        static let leading: CGFloat = 105
        static let minTrailing: CGFloat = 16
        static let font = Fonts.robotoRegular16
        static let color = Colors.textBlack
    }
    
    static let xOffset: CGFloat = 16
    static let currencyNameLeftOffset: CGFloat = 105
    static let currencyLabelOffset: CGFloat = 56
    
}

final class CurrencyCell: UITableViewCell {
    
    private typealias L = Locals
    
    // MARK: - Cell Height
    static let height: CGFloat = L.height
    
    // MARK: - Private
    private var model: CurrencyItem?
    private let iconView = UIImageView()
    private let label = UILabel()
    private let nameLabel = UILabel()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: nil)
        drawSelf()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        drawSelf()
    }
    
    // MARK: - Drawing
    private func drawSelf() {
        
        contentView.backgroundColor = L.backgroundColor
        
        iconView.backgroundColor = L.backgroundColor
        contentView.addSubview(iconView)
        iconView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            iconView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: L.Icon.leading),
            iconView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            iconView.heightAnchor.constraint(equalToConstant: L.Icon.size.height),
            iconView.widthAnchor.constraint(equalToConstant: L.Icon.size.width)
        ])
        
        nameLabel.font = L.Name.font
        nameLabel.textColor = L.Name.color
        contentView.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: L.Name.leading),
            nameLabel.trailingAnchor.constraint(greaterThanOrEqualTo: contentView.trailingAnchor, constant: -L.Name.minTrailing),
            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
        label.font = L.Label.font
        label.textColor = L.Label.color
        contentView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: L.Label.leading),
            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            label.trailingAnchor.constraint(greaterThanOrEqualTo: nameLabel.leadingAnchor, constant: L.Label.minTrailing)
        ])
    }
    
    // MARK: - Private methods
    override func prepareForReuse() {
        super.prepareForReuse()
        model = nil
        alpha = 1
        iconView.image = nil
        label.text = nil
        nameLabel.text = nil
    }
    
}

// MARK: - Setupable
extension CurrencyCell: Setupable {
    
    func setup(with model: CurrencyItem) {
        self.model = model
        contentView.alpha = model.isActive ? 1 : L.inactiveAlpha
        iconView.image = Images.countryFlag(for: model.currency)
        label.text = model.currency.label
        nameLabel.text = model.currency.name
    }
    
}
