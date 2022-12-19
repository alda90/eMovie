//
//  ComposableSection.swift
//  EMovie
//
//  Created by Aldair Carrillo on 18/12/22.
//

import UIKit


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/// MARK:  This distribution is clearer to read than having an only file the
/// composablecollectionview. But also this could be better with a generics implementation.
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

public class ComposableSection: NSObject {
    
    internal var collectionView: UICollectionView
    private var viewController: UIViewController
    
    internal static let sectionHeaderElementKind = "section-header-view-kind"
    internal enum Section: String, CaseIterable {
        case upcomings = "Próximos Estrenos"
        case topRated = "Tendencia"
        case callToActions = "Recomendados para ti"
        case recommendations = ""
    }
    internal var dataSource: UICollectionViewDiffableDataSource<Section, AnyHashable>?
    
    var output: ComposableSectionOutput = ComposableSectionOutput()
    
    public init(collectionView: UICollectionView, viewController: UIViewController) {
        self.collectionView = collectionView
        self.viewController = viewController
        super.init()
    }
    
    func setupCollectionView() {
        collectionView.setCollectionViewLayout(generateLayout(), animated: false)
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.reuseIdentifier)
        collectionView.register(ButtonCell.self, forCellWithReuseIdentifier: ButtonCell.reuseIdentifier)
        collectionView.register(
          HeaderView.self,
          forSupplementaryViewOfKind: ComposableSection.sectionHeaderElementKind,
          withReuseIdentifier: HeaderView.reuseIdentifier)
        collectionView.delegate = self
    }
    
    func bind() -> ComposableSectionOutput {
        return output
    }

    func updateSnapshot(movieLists: MovieLists) {
        configureDataSource()
        let snapshot = snapshotForCurrentState(movieLists)
        if let dataSource = self.dataSource {
            dataSource.apply(snapshot, animatingDifferences: false)
        }
    }
}

