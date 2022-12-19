//
//  HomeRouter.swift
//  EMovie
//
//  Created by Aldair Carrillo on 17/12/22.
//

import Foundation
import UIKit

/////////////////////// HOME ROUTER  PROTOCOL
protocol HomeRouterProtocol {
    var presenter: HomePresenterProtocol? { get set }
    static func createHomeModule() -> UIViewController
    func goToOptions(from view: HomeViewProtocol, recommendations: [Movie], typeAction: ActionGroup.TypeAction)
    func goToDetail(from view: HomeViewProtocol, movie: Movie)
}


////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////// HOME ROUTER
///////////////////////////////////////////////////////////////////////////////////////////////////
class HomeRouter: HomeRouterProtocol {
    
    var presenter: HomePresenterProtocol?
    
    static func createHomeModule() -> UIViewController {
        let view = HomeView()

        let interactor = HomeInteractor()
        let presenter: HomePresenterProtocol & HomeInteractorOutputProtocol = HomePresenter()
        let router = HomeRouter()

        router.presenter = presenter
        interactor.presenter = presenter
        presenter.router = router
        presenter.interactor = interactor
        view.presenter = presenter
        presenter.view = view
        
        return view
    }
    
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "HomeView", bundle: Bundle.main)
    }
    
    func goToOptions(from view: HomeViewProtocol, recommendations: [Movie], typeAction: ActionGroup.TypeAction) {
        let optionsView = OptionsRouter.createOptionsModule(recommendations: recommendations, typeAction: typeAction, delegate: self)
        
        if let vc = view as? UIViewController {
            vc.present(optionsView, animated: true)
        }
    }
    
    func goToDetail(from view: HomeViewProtocol, movie: Movie) {
        let detailView = DetailRouter.createDetailModule(movie: movie)
        
        if let vc = view as? UIViewController,
           let navController = vc.navigationController {
            let aView = navController.navigationBar.subviews
            presentSecundaryAnimation(viewToAnimate: detailView.view!, views: aView)
            vc.navigationController?.pushViewController(detailView, animated: false)
        }
        
    }
}

extension HomeRouter: OptionsDelegate {
    func actionItemSelected(_ item: String, typeAction: ActionGroup.TypeAction) {
        presenter?.getFilteredRecommendations(item: item, typeAction: typeAction)
    }
    
}

private extension HomeRouter {
    func presentSecundaryAnimation(viewToAnimate: UIView, views: [UIView]) {
        
        viewToAnimate.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)

        for viewTo in views {
            viewTo.frame.origin = CGPoint(x: 70, y: 100)
        }

        UIView.animate(
            withDuration: 0.8,
            delay: 0,
            options: .transitionCrossDissolve,
            animations: {
                for viewTo in views {
                    viewTo.frame.origin = CGPoint(x: 0, y: 0)
                }
            viewToAnimate.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }) { _ in
        }

    }
}
