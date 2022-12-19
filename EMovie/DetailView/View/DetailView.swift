//
//  DetailView.swift
//  EMovie
//
//  Created by Aldair Carrillo on 19/12/22.
//

import UIKit
import AVFoundation

/////////////////////// DETAIL VIEW PROTOCOL
protocol DetailViewProtocol: AnyObject {
    var presenter: DetailPresenterProtocol? { get set }
    func presenterGetDataView(receivedData: Movie, typeRow: [TypeDetailRow])
    func presenterGetError(error: String)
    func presenterGetYoutubeId(youtubeId: String?)
}

////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////// DETAIL VIEW
///////////////////////////////////////////////////////////////////////////////////////////////////

class DetailView: UIViewController {
    
    private lazy var btnBack: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(tappedAction), for: .touchUpInside)
        button.setImage(UIImage(named: "back"), for: .normal)
        return button
    }()
    
    private lazy var imgBack: UIImageView = {
        let image  = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = false
        
        return image
    }()
    
    private lazy var tableView: UITableView = {
        let tableView =  UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.register(DetailCell.self, forCellReuseIdentifier: DetailCell.reuseIdentifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    var presenter: DetailPresenterProtocol?
    private var movie: Movie?
    private var rows: [TypeDetailRow]?
    private var youtubeId: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter?.loadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
        navigationController?.navigationBar.isTranslucent = true
    }

}

extension DetailView: DetailViewProtocol {
    func presenterGetYoutubeId(youtubeId: String?) {
        self.youtubeId = youtubeId
    }
    
    
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
    

    func presenterGetDataView(receivedData: Movie, typeRow: [TypeDetailRow]) {
        movie = receivedData
        rows = typeRow
        
        DispatchQueue.main.async { [self] in
            self.imgBack.sd_setImage(with: receivedData.posterPathURL())
            self.imgBack.alpha = 0.5
            self.tableView.reloadData()
        }
        
    }
    
}

private extension DetailView {
    func setupView() {
        view.addSubview(btnBack)
        view.addSubview(imgBack)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            
            btnBack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            btnBack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            btnBack.heightAnchor.constraint(equalToConstant: 25),
            btnBack.widthAnchor.constraint(equalToConstant: 25),
            
            imgBack.topAnchor.constraint(equalTo: btnBack.bottomAnchor, constant: 8),
            imgBack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            imgBack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            imgBack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            
            tableView.topAnchor.constraint(equalTo: btnBack.bottomAnchor, constant: 8),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            
           
        ])
    }
    
    @objc func tappedAction() {
        presenter?.dismissView()
    }
    
}


extension DetailView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let rows = rows else { return 0 }
        
        return rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let rows = rows else { return UITableViewCell() }
        
        switch rows[indexPath.row] {
        case .data:
            let cell = tableView.dequeueReusableCell(withIdentifier: DetailCell.reuseIdentifier, for: indexPath) as! DetailCell
            cell.backgroundColor = .clear
            if let movie = movie {
                cell.configure(movie: movie, delegate: self)
            }
            
            return cell
        default:
            let cell = UITableViewCell()
            cell.selectionStyle = .none
            cell.backgroundColor = .clear
            return cell
        }
        
    }
    
}

extension DetailView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        guard let rows = rows else {
            return UITableView.automaticDimension
        }
        
        switch rows[indexPath.row] {
        case .space:
            return 360
        default:
            return UITableView.automaticDimension
        }
    }
}

extension DetailView: ActionVideoButtonDelegate {
    func actionVideo() {
        if let youtubeId = youtubeId,
            var url = URL(string:"youtube://\(youtubeId)") {
            if !UIApplication.shared.canOpenURL(url)  {
                url = URL(string:"http://www.youtube.com/watch?v=\(youtubeId)")!
            }
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    
    }
    
}
