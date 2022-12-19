//
//  DetailRouter.swift
//  EMovie
//
//  Created by Aldair Carrillo on 19/12/22.
//

import Foundation
import UIKit

/////////////////////// DETAIL ROUTER  PROTOCOL
protocol DetailRouterProtocol {
    static func createDetailModule(movie: Movie) -> UIViewController
//    func goToOptions(from view: HomeViewProtocol, recommendations: [Movie], typeAction: ActionGroup.TypeAction)
    func dismissView(from view: DetailViewProtocol)
}


////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////// DETAIL ROUTER
///////////////////////////////////////////////////////////////////////////////////////////////////
class DetailRouter: DetailRouterProtocol {
    
    
    static func createDetailModule(movie: Movie) -> UIViewController {
        let view = DetailView()
        
        let interactor = DetailInteractor()
        let presenter: DetailPresenterProtocol & DetailInteractorOutputProtocol = DetailPresenter(movie: movie)
        let router = DetailRouter()
        
        interactor.presenter = presenter
        presenter.router = router
        presenter.interactor = interactor
        view.presenter = presenter
        presenter.view = view
        
        return view
    }
    
    func dismissView(from view: DetailViewProtocol) {
        if let vc = view as? UIViewController {
            vc.navigationController?.popViewController(animated: true)
        }
    }
    
}
