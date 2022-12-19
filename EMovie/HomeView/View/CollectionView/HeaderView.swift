//
//  HeaderView.swift
//  EMovie
//
//  Created by Aldair Carrillo on 18/12/22.
//

import UIKit

class HeaderView: UICollectionReusableView {
  static let reuseIdentifier = "headerCell"

    lazy var label: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = .white
        lbl.numberOfLines = 1
        lbl.font = UIFont.systemFont(ofSize: 35.0)
        return lbl
    }()

  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }

  required init?(coder: NSCoder) {
    fatalError()
  }
}

extension HeaderView {
  func configure() {
    backgroundColor = .clear

    addSubview(label)
    label.translatesAutoresizingMaskIntoConstraints = false

    let inset = CGFloat(10)
    NSLayoutConstraint.activate([
      label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: inset),
      label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -inset),
      label.topAnchor.constraint(equalTo: topAnchor, constant: inset),
      label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -inset)
    ])
    label.font = UIFont.preferredFont(forTextStyle: .title3)
  }
}
