//
//  ConversionRateCell.swift
//  Created by Alexander Antonov on 12/04/2019.
//

import UIKit

private enum Locals {
    
    static let background = Colors.whiteBackground
    
    static let titleFont = Fonts.robotoMedium20
    static let subtitleFont = Fonts.robotoRegular14
    static let centicentsFont = Fonts.robotoMedium14
    
    static let titleColor = Colors.textBlack
    static let subtitleColor = Colors.textGray
    
    static let xOffset: CGFloat = 16
    static let titleTopOffset: CGFloat = 16
    static let subtitleTopOffset: CGFloat = 0
    static let secondSutitlesSpacing: CGFloat = 6
    static let namesMinSpacing: CGFloat = 8
    static let noValuePlaceholder = "— —"
}

final class ConversionRateCell: UITableViewCell {
    
    private typealias L = Locals
    
    // MARK: - Properties
    static let height: CGFloat = 80
    
    private(set) var model: Model?
    private let firstTitleLabel = UILabel()
    private let firstNameLabel = UILabel()
    private let secondValueLabel = UILabel()
    private let secondCenticentsLabel = UILabel()
    private let secondLabel = UILabel()
    private let secondNameLabel = UILabel()
    
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
        
        selectionStyle = .none
        contentView.backgroundColor = L.background
        
        firstTitleLabel.font = L.titleFont
        firstTitleLabel.textColor = L.titleColor
        contentView.addSubview(firstTitleLabel)
        firstTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            firstTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: L.xOffset),
            firstTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: L.titleTopOffset)
        ])
        
        firstNameLabel.font = L.subtitleFont
        firstNameLabel.textColor = L.subtitleColor
        contentView.addSubview(firstNameLabel)
        firstNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            firstNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: L.xOffset),
            firstNameLabel.topAnchor.constraint(equalTo: firstTitleLabel.bottomAnchor, constant: L.subtitleTopOffset)
        ])
        
        secondValueLabel.textAlignment = .right
        secondValueLabel.font = L.titleFont
        secondValueLabel.textColor = L.titleColor
        contentView.addSubview(secondValueLabel)
        secondValueLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            secondValueLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -L.xOffset),
            secondValueLabel.lastBaselineAnchor.constraint(equalTo: firstTitleLabel.lastBaselineAnchor)
        ])
        
        secondCenticentsLabel.textAlignment = .right
        secondCenticentsLabel.font = L.centicentsFont
        secondCenticentsLabel.textColor = L.titleColor
        contentView.addSubview(secondCenticentsLabel)
        secondCenticentsLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            secondCenticentsLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -L.xOffset),
            secondCenticentsLabel.leftAnchor.constraint(equalTo: secondValueLabel.rightAnchor, constant: 1),
            secondCenticentsLabel.lastBaselineAnchor.constraint(equalTo: firstTitleLabel.lastBaselineAnchor)
        ])
        
        secondLabel.textAlignment = .right
        secondLabel.font = L.subtitleFont
        secondLabel.textColor = L.subtitleColor
        contentView.addSubview(secondLabel)
        secondLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            secondLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -L.xOffset),
            secondLabel.lastBaselineAnchor.constraint(equalTo: firstNameLabel.lastBaselineAnchor)
        ])
        
        secondNameLabel.textAlignment = .right
        secondNameLabel.font = L.subtitleFont
        secondNameLabel.textColor = L.subtitleColor
        contentView.addSubview(secondNameLabel)
        secondNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            secondNameLabel.trailingAnchor.constraint(equalTo: secondLabel.leadingAnchor, constant: -L.secondSutitlesSpacing),
            secondNameLabel.lastBaselineAnchor.constraint(equalTo: firstNameLabel.lastBaselineAnchor),
            secondNameLabel.leadingAnchor.constraint(greaterThanOrEqualTo: firstNameLabel.trailingAnchor, constant: L.namesMinSpacing)
        ])
        
    }
    
}

// MARK: - Setupable
extension ConversionRateCell: Setupable {
    
    struct Model: Equatable {
        let pair: CurrencyPair
        let valueText: ValueText?
    }
    
    func setup(with model: Model) {
        
        self.model = model
        
        let first = model.pair.first
        firstTitleLabel.text = "1 \(first.label)"
        firstNameLabel.text = first.name
        
        let second = model.pair.second
        secondLabel.text = second.label
        secondNameLabel.text = second.name
        
        updateRate(with: model.valueText)
    }
    
    func updateRate(with valueText: ValueText?) {
        if let valueText = valueText {
            secondValueLabel.text = valueText.mainValue
            secondCenticentsLabel.text = valueText.centicents
        } else {
            secondValueLabel.text = L.noValuePlaceholder
            secondCenticentsLabel.text = ""
        }
    }
    
}
