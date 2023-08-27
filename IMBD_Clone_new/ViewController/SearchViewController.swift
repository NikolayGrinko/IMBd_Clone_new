//
//  SearchViewController.swift
//  IMBD_Clone_new
//
//  Created by Николай Гринько on 26.08.2023.
//

import UIKit

class SearchViewController: UIViewController {
    private var topInsetView = UIView()
    
    private let textFields: UITextField = {
         let textField = UITextField()
         textField.text = "UIMb"
         textField.textColor = .black
         textField.frame = CGRect(x: 160, y: 60, width: 100, height: 20)
        textField.font = .systemFont(ofSize: 30, weight: .bold)
         return textField
     }()
    
    private let discoverTable: UITableView = {
        let table = UITableView()
        table.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.identifier)
        return table
    }()
    
    private let searchController: UISearchController = {
        
        let controller = UISearchController(searchResultsController: SearchResultsViewController())
        controller.searchBar.placeholder = "Search for a Movie or a Tv show"
        controller.searchBar.searchBarStyle = .minimal
        return controller
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Search"
        topInsetView.backgroundColor = #colorLiteral(red: 1, green: 0.8280770183, blue: 0, alpha: 1)
        view.addSubview(topInsetView)
        view.addSubview(textFields)
        
        navigationItem.searchController = searchController
        //searchController.searchResultsUpdater = self
        
        view.addSubview(discoverTable)
        discoverTable.delegate = self
        discoverTable.dataSource = self
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        discoverTable.frame = view.bounds
        topInsetView.frame = CGRect(x: 0, y: 0,
                                    width: view.frame.width,
                                    height: view.safeAreaInsets.top - 50)
    }
    
}



extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifier, for: indexPath) as? TitleTableViewCell else {
            return UITableViewCell()
        }

        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
   
        }
    
}

