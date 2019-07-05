//
//  AddView.swift
//  Created by Alexander Antonov on 11/04/2019.
//

import UIKit

protocol AddActionDelegate: AnyObject {
    func didTapAdd()
}

private enum Locals {
    
    enum Icon {
        static let topOffset: CGFloat = 10
        static let size = CGSize(width: 50, height: 50)
        static let image = Images.plusSign
    }
    
    enum Title {
        static let font = Fonts.robotoMedium16
        static let color = Colors.textBlue
        static let topOffset: CGFloat = 10
        static let bottomOffset: CGFloat = -4
        static let maxWidth: CGFloat = 240
    }
    
}

final class AddView: UIView {
    
    private typealias L = Locals
    
    // MARK: - Properties
    weak var delegate: AddActionDelegate?
    
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        drawSelf()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        drawSelf()
    }
    
    // MARK: - Drawing
    private func drawSelf() {
        
        imageView.image = L.Icon.image
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: L.Icon.size.height),
            imageView.widthAnchor.constraint(equalToConstant: L.Icon.size.width),
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: L.Icon.topOffset),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            widthAnchor.constraint(greaterThanOrEqualTo: imageView.widthAnchor),
        ])
        
        titleLabel.font = L.Title.font
        titleLabel.textColor = L.Title.color
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: L.Title.topOffset),
            titleLabel.widthAnchor.constraint(lessThanOrEqualToConstant: L.Title.maxWidth),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: L.Title.bottomOffset),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(actionTap))
        addGestureRecognizer(tapRecognizer)
    }
    
    // MARK: - Action
    @objc
    private func actionTap() {
        delegate?.didTapAdd()
    }
    
}

// MARK: - Setupable
extension AddView: Setupable {
    
    struct Model {
        let title: String
    }
    
    func setup(with model: Model) {
        titleLabel.text = model.title
    }
    
}
