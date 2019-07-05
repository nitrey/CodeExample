//
//  LargeAddCell.swift
//  Created by Alexander Antonov on 11/04/2019.
//

import UIKit

private enum Locals {
    
    static let background = Colors.whiteBackground
    
    enum Descripiton {
        static let font = Fonts.robotoRegular16
        static let color = Colors.textGray
        static let topOffset: CGFloat = 4
        static let maxWidth: CGFloat = 320
    }
    
}

final class LargeAddCell: UITableViewCell {
    
    private typealias L = Locals
    
    // MARK: - Properties
    weak var delegate: AddActionDelegate? {
        didSet {
            addView.delegate = delegate
        }
    }
    private let canvasView = UIView()
    private let addView = AddView()
    private let descriptionLabel = UILabel()
    
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
        
        canvasView.backgroundColor = L.background
        contentView.addSubview(canvasView)
        canvasView.translatesAutoresizingMaskIntoConstraints = false
        
        addView.backgroundColor = L.background
        canvasView.addSubview(addView)
        addView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addView.centerXAnchor.constraint(equalTo: canvasView.centerXAnchor),
            addView.topAnchor.constraint(equalTo: canvasView.topAnchor),
            addView.widthAnchor.constraint(lessThanOrEqualTo: canvasView.widthAnchor)
        ])
        
        descriptionLabel.font = L.Descripiton.font
        descriptionLabel.textColor = L.Descripiton.color
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textAlignment = .center
        canvasView.addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: addView.bottomAnchor, constant: L.Descripiton.topOffset),
            descriptionLabel.widthAnchor.constraint(lessThanOrEqualToConstant: L.Descripiton.maxWidth),
            descriptionLabel.leadingAnchor.constraint(equalTo: canvasView.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: canvasView.trailingAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: canvasView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            canvasView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            canvasView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
}

// MARK: - Setupable
extension LargeAddCell: Setupable {
    
    struct Model {
        let title: String
        let description: String
    }
    
    func setup(with model: Model) {
        descriptionLabel.text = model.description
        let addViewModel = AddView.Model(title: model.title)
        addView.setup(with: addViewModel)
    }
    
}
