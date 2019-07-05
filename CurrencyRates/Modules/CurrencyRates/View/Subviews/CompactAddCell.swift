//
//  CompactAddCell.swift
//  Created by Alexander Antonov on 13/04/2019.
//

import UIKit

private enum Locals {
    
    static let background = Colors.whiteBackground
    static let image = Images.plusSign
    static let titleFont = Fonts.robotoMedium16
    static let titleColor = Colors.textBlue
    static let xOffset: CGFloat = 16
    static let iconTitleSpacing: CGFloat = 16
}

final class CompactAddCell: UITableViewCell {
    
    private typealias L = Locals
    
    // MARK: - Properties
    static let height: CGFloat = 72
    
    weak var delegate: AddActionDelegate?
    
    private let iconView = UIImageView()
    private let titleLabel = UILabel()

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
        
        contentView.backgroundColor = L.background
        
        iconView.image = L.image
        contentView.addSubview(iconView)
        iconView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            iconView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: L.xOffset),
            iconView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
        titleLabel.textAlignment = .left
        titleLabel.font = L.titleFont
        titleLabel.textColor = L.titleColor
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: L.iconTitleSpacing),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(actionTap))
        contentView.addGestureRecognizer(tapRecognizer)
    }
    
    // MARK: - Action
    @objc
    private func actionTap() {
        delegate?.didTapAdd()
    }

}

// MARK: - Setupable
extension CompactAddCell: Setupable {
    
    struct Model {
        let title: String
    }
    
    func setup(with model: Model) {
        titleLabel.text = model.title
    }
    
}
