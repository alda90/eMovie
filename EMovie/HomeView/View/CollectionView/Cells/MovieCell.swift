//
//  UpcomingMovieCell.swift
//  EMovie
//
//  Created by Aldair Carrillo on 18/12/22.
//

import Foundation
import UIKit
import SDWebImage



////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/// MARK: The cache has some conflicts, it has to be fixed. And I has to be improved
/// with local storage like Realm or CoreData
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class MovieCell: UICollectionViewCell {
    static let reuseIdentifier = "upcomingCell"
    private let cache = NSCache<NSString, UIImage>()
    let posterImage = UIImageView()
    let contentContainer = UIView()

    var posterPathURL: URL? {
        didSet {
            configure()
        }
    }
    
    var id: String?

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MovieCell {
    func configure() {
        contentView.addSubview(posterImage)

        posterImage.translatesAutoresizingMaskIntoConstraints = false
        if let cacheImage = cache.object(forKey: NSString(string: id ?? "image")) {
            posterImage.image = cacheImage
        } else {
            if let url = posterPathURL {
                posterImage.sd_setImage(with: url) { [weak self] image, error, _, _ in
                    guard let self = self else { return }
                    if let image = image {
                        self.posterImage.image = image
                        self.cache.setObject(image, forKey: NSString(string: self.id ?? "image"))
                    }
                }
            }
        }
        
        posterImage.layer.cornerRadius = 10
        posterImage.clipsToBounds = true

        NSLayoutConstraint.activate([
            posterImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            posterImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            posterImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            posterImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
