//
//  ComposableSectionDataSource.swift
//  EMovie
//
//  Created by Aldair Carrillo on 18/12/22.
//

import UIKit

// MARK: DataSource
internal extension ComposableSection {

    func configureDataSource() {
            dataSource = UICollectionViewDiffableDataSource
            <Section, AnyHashable>(collectionView: collectionView) {
                (collectionView: UICollectionView, indexPath: IndexPath, movieItem: AnyHashable) -> UICollectionViewCell? in
                
                let sectionType = Section.allCases[indexPath.section]
                switch sectionType {
                case .upcomings, .topRated, .recommendations:
                    guard let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: MovieCell.reuseIdentifier,
                        for: indexPath) as? MovieCell else { fatalError("Could not create new cell") }
                    let item = movieItem as! Movie
                    cell.posterPathURL = item.posterPathURL()
                    cell.id = "\(item.id)"
                    return cell
                case .callToActions:
                    guard let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: ButtonCell.reuseIdentifier,
                        for: indexPath) as? ButtonCell else { fatalError("Could not create new cell") }
                    let item = movieItem as! ActionGroup
                    cell.configure(item, delegate: self)
                    return cell
                }
            }
            
            dataSource?.supplementaryViewProvider = { (
                collectionView: UICollectionView,
                kind: String,
                indexPath: IndexPath) -> UICollectionReusableView? in
                
                guard let supplementaryView = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier: HeaderView.reuseIdentifier,
                    for: indexPath) as? HeaderView else { fatalError("Cannot create header view") }
                
                supplementaryView.label.text = Section.allCases[indexPath.section].rawValue
                return supplementaryView
            }
            
        }
        
        func snapshotForCurrentState(_ movieLists: MovieLists) -> NSDiffableDataSourceSnapshot<Section, AnyHashable> {
            
            let upcomings = movieLists.upcomings
            let topRateds = movieLists.topRated
            let recommedations = movieLists.recommendations
            let actions = movieLists.acions
            
            var snapshot = NSDiffableDataSourceSnapshot<Section, AnyHashable>()
            snapshot.appendSections([Section.upcomings])
            snapshot.appendItems(upcomings)

            snapshot.appendSections([Section.topRated])
            snapshot.appendItems(topRateds)
            
            snapshot.appendSections([Section.callToActions])
            snapshot.appendItems(actions)

            snapshot.appendSections([Section.recommendations])
            snapshot.appendItems(recommedations)
            
            return snapshot
        }
    
}
