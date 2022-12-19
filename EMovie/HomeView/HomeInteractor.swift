//
//  HomeInteractor.swift
//  EMovie
//
//  Created by Aldair Carrillo on 17/12/22.
//

import Foundation

/////////////////////// HOME INTERACTOR PROTOCOLS
protocol HomeInteractorOutputProtocol: AnyObject {
    func interactorGetDataPresenter(receivedData: MovieLists, error: Error?)
}

protocol HomeInteractorInputProtocol {
    var presenter: HomeInteractorOutputProtocol? { get set }
    func getMoviesFromService()
}

////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////// HOME INTERACTOR
///////////////////////////////////////////////////////////////////////////////////////////////////

class HomeInteractor: HomeInteractorInputProtocol {
    weak var presenter: HomeInteractorOutputProtocol?
    
    private var upcomings: [Movie] = []
    private var topRated: [Movie] = []
    private var recommendations: [Movie] = []
    private var error: Error?
    
    func getMoviesFromService() {
        
        let group = DispatchGroup()
        let services: [NetworkRouter] = [.getUpcomings, .getTopRated, .getPopular]
        
        services.forEach { service in
            group.enter()
            NetworkManager.shared.request(networkRouter: service) { [weak self] (result: NetworkResult<MovieResponse>) in
                self?.getMoviesData(result, router: service)
                group.leave()
            }
        }
        
        group.notify(queue: .main) { [self] in
            self.sendDataToPresenter()
        }
    }
    
}

private extension HomeInteractor  {
    
    func getMoviesData(_ result: NetworkResult<MovieResponse>, router: NetworkRouter) {
        
        switch result {
        case .success(let response):
            switch router {
            case .getUpcomings: upcomings = response.movies
            case .getTopRated: topRated = response.movies
            case .getPopular: recommendations = response.movies
            default:
                break
            }
        case .failure(let err):
            error  = err
        }
        
    }
    
    func sendDataToPresenter() {
        let actions = getActionGroupList()
        let movieLists = MovieLists(upcomings: upcomings, topRated: topRated, recommendations: recommendations, acions: actions)
        presenter?.interactorGetDataPresenter(receivedData: movieLists, error: error)
    }
    
    func getActionGroupList() -> [ActionGroup] {
        let actions = [
            ActionGroup(title: "Idioma", action: .language, style: .light),
            ActionGroup(title: "Año", action: .year, style: .dark)
        ]
        return actions
    }
}


