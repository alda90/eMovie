//
//  OptionsRouter.swift
//  EMovie
//
//  Created by Aldair Carrillo on 18/12/22.
//

import Foundation
import UIKit

/////////////////////// OPTIONS ROUTER  PROTOCOL
protocol OptionsRouterProtocol: AnyObject {
    var delegate: OptionsDelegate? { get set }
    var typeAction: ActionGroup.TypeAction? { get set}
    static func createOptionsModule(recommendations: [Movie], typeAction: ActionGroup.TypeAction, delegate: OptionsDelegate) -> UIViewController
    func dismissView(from view: OptionsViewProtocol, item: String)
}

protocol OptionsDelegate: AnyObject {
    func actionItemSelected(_ item: String, typeAction: ActionGroup.TypeAction)
}

////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////// OPTIONS ROUTER
///////////////////////////////////////////////////////////////////////////////////////////////////
///
class OptionsRouter {
    weak var delegate: OptionsDelegate?
    var typeAction: ActionGroup.TypeAction?
}

extension OptionsRouter: OptionsRouterProtocol {
    
    static func createOptionsModule(recommendations: [Movie], typeAction: ActionGroup.TypeAction, delegate: OptionsDelegate) -> UIViewController {
        
        let view = OptionsView()
        let presenter: OptionsPresenterProtocol = OptionsPresenter(recommendations: recommendations, typeAction: typeAction)
        let router = OptionsRouter()
        
        router.delegate =  delegate
        router.typeAction = typeAction
        presenter.router = router
        view.presenter = presenter
        presenter.view = view

        return view
    }
    
    
    func dismissView(from view: OptionsViewProtocol, item: String) {
        if let vc = view as? UIViewController,
           let type = typeAction {
            delegate?.actionItemSelected(item, typeAction: type)
            vc.dismiss(animated: true)
        }
    }
}

