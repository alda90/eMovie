//
//  HomePresenter.swift
//  EMovie
//
//  Created by Aldair Carrillo on 17/12/22.
//

import Foundation

/////////////////////// HOME PRESENTER PROTOCOL
protocol HomePresenterProtocol: AnyObject {
    var view: HomeViewProtocol? { get set }
    var interactor: HomeInteractorInputProtocol? { get set }
    var router: HomeRouterProtocol? { get set }
    
    func loadData()
    func getFilteredRecommendations(item: String, typeAction: ActionGroup.TypeAction)
    func goToOptions(typeAction: ActionGroup.TypeAction)
    func goToDetail(movie: Movie)
}

////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////// HOME PRESENTER
///////////////////////////////////////////////////////////////////////////////////////////////////

class HomePresenter {
    
    weak var view: HomeViewProtocol?
    var interactor: HomeInteractorInputProtocol?
    var router: HomeRouterProtocol?
    
    private var movieLists: MovieLists?
    private var recommendations: [Movie] = []
}

extension HomePresenter: HomeInteractorOutputProtocol {
    func interactorGetDataPresenter(receivedData: MovieLists, error: Error?) {
        
        
    
        if let error = error {
            view?.presenterGetError(error: error.localizedDescription)
         
        } else {
            movieLists = receivedData
            recommendations = receivedData.recommendations
            filterRecommendations(recommendations: recommendations)
        }
        
    }
}

extension HomePresenter: HomePresenterProtocol {
    
    func loadData() {
        interactor?.getMoviesFromService()
    }
    
    func getFilteredRecommendations(item: String, typeAction: ActionGroup.TypeAction) {
        var elements: [Movie] = []
        
        if typeAction == .year {
            let calendar = Calendar.current
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            
            elements = recommendations.filter {
                String(calendar.component(.year, from: dateFormatter.date(from: $0.releaseDate) ?? Date())) == item
            }
            
        } else {
            elements = recommendations.filter {
                $0.originalLanguage == item
            }
        }
        
        filterRecommendations(recommendations: elements)
    }
    
    func goToOptions(typeAction: ActionGroup.TypeAction) {
        router?.goToOptions(from: view!, recommendations: recommendations, typeAction: typeAction)
    }
    
    func goToDetail(movie: Movie) {
        router?.goToDetail(from: view!, movie: movie)
    }
}

private extension HomePresenter {
    func filterRecommendations(recommendations: [Movie]) {
        movieLists?.recommendations = recommendations.count > 6 ? Array(recommendations[...5]) : recommendations
        presenterGetDataView()
    }
    
    func presenterGetDataView() {
        if let movieLists = movieLists {
            view?.presenterGetDataView(receivedData: movieLists)
        }
    }
}
