//
//  DetailPresenter.swift
//  EMovie
//
//  Created by Aldair Carrillo on 19/12/22.
//

import Foundation

/////////////////////// DETAIL PRESENTER PROTOCOL
protocol DetailPresenterProtocol: AnyObject {
    var view: DetailViewProtocol? { get set }
    var interactor: DetailInteractorInputProtocol? { get set }
    var router: DetailRouterProtocol? { get set }
    
    func loadData()
    func dismissView()
}

enum TypeDetailRow {
    case space
    case data
}

////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////// DETAIL PRESENTER
///////////////////////////////////////////////////////////////////////////////////////////////////

class DetailPresenter {
    
    weak var view: DetailViewProtocol?
    var interactor: DetailInteractorInputProtocol?
    var router: DetailRouterProtocol?
    
    private var movie: Movie?
    
    init(movie: Movie) {
        self.movie = movie
    }
}

extension DetailPresenter: DetailInteractorOutputProtocol {
    func interactorGetDataPresenter(receivedData: [Video], error: Error?) {
        let youtube = receivedData.first {
            $0.site == "YouTube"
        }
        
        if let path = youtube {
            view?.presenterGetYoutubeId(youtubeId: path.key)
        }
    }
}

extension DetailPresenter: DetailPresenterProtocol {
    func dismissView() {
        router?.dismissView(from: view!)
    }
    

    func loadData() {
        let rows = [TypeDetailRow.space, TypeDetailRow.data]
        if let movie = movie {
            view?.presenterGetDataView(receivedData: movie, typeRow: rows)
            interactor?.getVideosFromService(id: movie.id)
        }
    }

}

