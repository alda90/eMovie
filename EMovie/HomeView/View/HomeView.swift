//
//  HomeView.swift
//  EMovie
//
//  Created by Aldair Carrillo on 17/12/22.
//

import UIKit
import Combine

/////////////////////// HOME VIEW PROTOCOL
protocol HomeViewProtocol: AnyObject {
    var presenter: HomePresenterProtocol? { get set }
    func presenterGetDataView(receivedData: MovieLists)
    func presenterGetError(error: String)
}

////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////// HOME VIEW 
///////////////////////////////////////////////////////////////////////////////////////////////////

class HomeView: UIViewController {
    
    var presenter: HomePresenterProtocol?
    
    private lazy var imgLogo: UIImageView = {
        let image  = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = false
        image.image = UIImage(named: "logo")
        return image
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    private lazy var collectionAdapter: ComposableSection = {
        let adapter = ComposableSection(collectionView: collectionView, viewController: self)
        return adapter
    }()

    private var subscriptions = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        bind()
        presenter?.loadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
        navigationController?.navigationBar.isTranslucent = true
    }
    
    private func bind() {
        let output = collectionAdapter.bind()
        output.callToAction
            .receive(on: DispatchQueue.main)
            .sink { [weak self] movie in
                self?.presenter?.goToDetail(movie: movie)
            }
            .store(in: &subscriptions)
            
        output.navigateTo
            .receive(on: DispatchQueue.main)
            .sink { [weak self] action in
                self?.presenter?.goToOptions(typeAction: action)
            }
            .store(in: &subscriptions)
    }
}

extension HomeView: HomeViewProtocol {
    func presenterGetError(error: String) {
        self.openAlert(title: "We are sorry, and error has ocurred!",
                              message: error,
                             alertStyle: .alert,
                              actionTitles: ["Ok"],
                              actionStyles: [.default],
                              actions: [ {_ in
                                            print("Ok")
                                        },])
    }
    

    func presenterGetDataView(receivedData: MovieLists) {
        collectionAdapter.updateSnapshot(movieLists: receivedData)
    }
    
}

private extension HomeView {
    func setupView() {
        view.addSubview(imgLogo)
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            
            imgLogo.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            imgLogo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imgLogo.widthAnchor.constraint(equalToConstant: 145),
            imgLogo.heightAnchor.constraint(equalToConstant: 45),
            
            collectionView.topAnchor.constraint(equalTo: imgLogo.bottomAnchor, constant: 0),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
        collectionAdapter.setupCollectionView()
    }
    
}

extension HomeView: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {

        switch toVC {
        case is DetailView:
            return AnimationController(animationType: .secundary)
        default:
            break
        }
        return nil

    }
}
