//
//  DetailCell.swift
//  EMovie
//
//  Created by Aldair Carrillo on 19/12/22.
//

import Foundation
import UIKit

protocol ActionVideoButtonDelegate: AnyObject {
    func actionVideo()
}

class DetailCell: UITableViewCell {
    static let reuseIdentifier = "detailCell"
    weak var delegate: ActionVideoButtonDelegate?
    
    private lazy var lblTitle: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .center
        lbl.textColor = .white
        lbl.numberOfLines = 2
        lbl.font = UIFont.systemFont(ofSize: 35.0)
        return lbl
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fillProportionally
        stack.spacing = 10
        return stack
    }()
    
    private lazy var lblYear: UILabel = {
        let lbl = PaddingLabel()
        lbl.padding(2, 2, 5, 5)
        lbl.textAlignment = .center
        lbl.backgroundColor = .lightGray
        lbl.textColor = .black
        lbl.layer.cornerRadius = 8
        lbl.layer.masksToBounds = true
        return lbl
    }()
    
    private lazy var lblLanguage: UILabel = {
        let lbl = PaddingLabel()
        lbl.padding(2, 2, 5, 5)
        lbl.textAlignment = .center
        lbl.backgroundColor = .lightGray
        lbl.textColor = .black
        lbl.layer.cornerRadius = 8
        lbl.layer.masksToBounds = true
        return lbl
    }()
    
    private lazy var lblRating: UILabel = {
        let lbl = PaddingLabel()
        lbl.padding(2, 2, 5, 5)
        lbl.textAlignment = .center
        lbl.backgroundColor = .yellow
        lbl.textColor = .black
        lbl.layer.cornerRadius = 8
        lbl.layer.masksToBounds = true
        return lbl
    }()
    
    private lazy var btnVideo: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Ver Trailer", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.layer.borderColor = UIColor.lightGray.cgColor
        btn.layer.borderWidth = 2
        btn.layer.cornerRadius = 8
        btn.addTarget(self, action: #selector(tappedAction), for: .touchUpInside)
        return btn
    }()
    
    private lazy var lblOverview: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = .white
        lbl.numberOfLines = 0
        lbl.textAlignment = .justified
        return lbl
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(movie: Movie, delegate: ActionVideoButtonDelegate) {
        selectionStyle = .none
        lblTitle.text = movie.originalTitle
        lblYear.text = getYearString(dateString: movie.releaseDate)
        lblLanguage.text = movie.originalLanguage
        let star = "\u{2606}"
        lblRating.text = "\(star) \(movie.voteAverage)"
        lblOverview.text = movie.overview
        self.delegate = delegate
    }
}

private extension DetailCell {
    func setupView() {

        contentView.addSubview(lblTitle)
        contentView.addSubview(stackView)
        contentView.addSubview(btnVideo)
        contentView.addSubview(lblOverview)
        stackView.addArrangedSubview(lblYear)
        stackView.addArrangedSubview(lblLanguage)
        stackView.addArrangedSubview(lblRating)
        
        
        NSLayoutConstraint.activate([
            lblTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            lblTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            lblTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            
            stackView.topAnchor.constraint(equalTo: lblTitle.bottomAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            btnVideo.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 16),
            btnVideo.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            btnVideo.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            btnVideo.heightAnchor.constraint(equalToConstant: 45),
            
            lblOverview.topAnchor.constraint(equalTo: btnVideo.bottomAnchor, constant: 16),
            lblOverview.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            lblOverview.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            lblOverview.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
    
    func getYearString(dateString: String) -> String {
        let calendar = Calendar.current
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        return String(calendar.component(.year, from: dateFormatter.date(from: dateString) ?? Date()))
    }
    
    @objc func tappedAction() {
        delegate?.actionVideo()
    }
}
