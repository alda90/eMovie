//
//  OptionsPresenter.swift
//  EMovie
//
//  Created by Aldair Carrillo on 18/12/22.
//

import Foundation

/////////////////////// OPTIONS PRESENTER PROTOCOL
protocol OptionsPresenterProtocol: AnyObject {
    var view: OptionsViewProtocol? { get set }
    var router: OptionsRouterProtocol? { get set }
    
    func loadData()
    func selectedItem(item: String)
}

////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////// OPTIONS PRESENTER
///////////////////////////////////////////////////////////////////////////////////////////////////

class OptionsPresenter {
    
    weak var view: OptionsViewProtocol?
    var router: OptionsRouterProtocol?
    private var recommendations: [Movie]
    private var typeAction: ActionGroup.TypeAction
    
    init(recommendations: [Movie], typeAction: ActionGroup.TypeAction) {
        self.recommendations = recommendations
        self.typeAction = typeAction
    }
}

extension OptionsPresenter: OptionsPresenterProtocol {
    
    func loadData() {
        
        let elements: Set<String>
        
        if typeAction == .year {
            let calendar = Calendar.current
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            
            elements = Set(recommendations.compactMap {
                String(calendar.component(.year, from: dateFormatter.date(from: $0.releaseDate) ?? Date()))
            })
            
        } else {
            elements = Set(recommendations.compactMap({
                $0.originalLanguage
            }))
        }
        
        view?.presenterGetDataView(receivedData: Array(elements))
    }
    
    func selectedItem(item: String) {
        router?.dismissView(from: view!, item: item)
    }
}

