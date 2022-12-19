//
//  OptionsView.swift
//  EMovie
//
//  Created by Aldair Carrillo on 18/12/22.
//

import UIKit

protocol OptionsViewProtocol: AnyObject {
    var presenter: OptionsPresenterProtocol? { get set }
    func presenterGetDataView(receivedData: [String])
}

////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////// OPTIONS VIEW
///////////////////////////////////////////////////////////////////////////////////////////////////

class OptionsView: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tableView =  UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    var presenter: OptionsPresenterProtocol?
    private var elements: [String] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkGray
        setupView()
        presenter?.loadData()
    }
    
}

extension OptionsView: OptionsViewProtocol {
    func presenterGetDataView(receivedData: [String]) {
        elements = receivedData
        tableView.reloadData()
    }
}

private extension OptionsView {
    func setupView() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
    }
}

extension OptionsView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return elements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = elements[indexPath.row]
        cell.textLabel?.textColor = .white
        cell.backgroundColor = .clear
        return cell
    }
    
    
}

extension OptionsView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = elements[indexPath.row]
        presenter?.selectedItem(item: item)
    }
}
