//
//  DetailInteractor.swift
//  EMovie
//
//  Created by Aldair Carrillo on 19/12/22.
//

import Foundation

/////////////////////// DETAIL  INTERACTOR PROTOCOLS
protocol DetailInteractorOutputProtocol: AnyObject {
    func interactorGetDataPresenter(receivedData: [Video], error: Error?)
}

protocol DetailInteractorInputProtocol {
    var presenter: DetailInteractorOutputProtocol? { get set }
    func getVideosFromService(id: Int)
}

////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////// DETAIL INTERACTOR
///////////////////////////////////////////////////////////////////////////////////////////////////

class DetailInteractor: DetailInteractorInputProtocol {

    weak var presenter: DetailInteractorOutputProtocol?
    
    func getVideosFromService(id: Int) {
        NetworkManager.shared.request(networkRouter: NetworkRouter.getVideos(id: id)) { [weak self] (result: NetworkResult<VideoResponse>) in
            
            var videos: [Video] = []
            var error: Error?
            
            switch result {
            case .success(let response):
                videos = response.videos
            case .failure(let err):
                error  = err
            }
            
            self?.presenter?.interactorGetDataPresenter(receivedData: videos, error: error)
        }
    }
    
}

private extension DetailInteractor  {
    
}
