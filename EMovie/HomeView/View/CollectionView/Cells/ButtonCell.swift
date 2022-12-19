//
//  ButtonCell.swift
//  EMovie
//
//  Created by Aldair Carrillo on 18/12/22.
//

import Foundation
import UIKit

protocol ActionButtonDelegate: AnyObject {
    func actionButton(_ action: ActionGroup.TypeAction)
}

class ButtonCell: UICollectionViewCell {
    
    static let reuseIdentifier = "buttonCell"
    weak var delegate: ActionButtonDelegate?
    
    
    private lazy var selectButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(tappedAction), for: .touchUpInside)
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.borderWidth = 2
        button.layer.cornerRadius = 8
        return button
    }()
    
    private var title: String? {
        didSet {
            selectButton.setTitle(title, for: .normal)
        }
    }
    
    private var typeAction: ActionGroup.TypeAction?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(_ actionGroup: ActionGroup, delegate: ActionButtonDelegate) {
        title = actionGroup.title
        typeAction = actionGroup.action
        selectButton.layer.backgroundColor = actionGroup.style == .dark ? UIColor.black.cgColor : UIColor.lightGray.cgColor
        self.delegate = delegate
    }
}

private extension ButtonCell {
    func setupView() {
        contentView.addSubview(selectButton)

        NSLayoutConstraint.activate([
            selectButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            selectButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            selectButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            selectButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    @objc func tappedAction() {
        if  let action = typeAction {
            delegate?.actionButton(action)
        }
    }
}
