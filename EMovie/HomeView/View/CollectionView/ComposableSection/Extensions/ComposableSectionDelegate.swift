//
//  ComposableSectionDelegate.swift
//  EMovie
//
//  Created by Aldair Carrillo on 18/12/22.
//

import UIKit

extension ComposableSection: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let source = dataSource,
              let item = source.itemIdentifier(for: indexPath),
              let movie = item as? Movie else { return }
        
        output.callToAction.send(movie)
    }
}

extension ComposableSection: ActionButtonDelegate {
    func actionButton(_ action: ActionGroup.TypeAction) {
        output.navigateTo.send(action)
    }
    
}
