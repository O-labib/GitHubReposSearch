//
//  ReposListViewController.swift
//  iOSTechnicalTask
//
//  Created by mac on 3/4/21.
//

import UIKit

class ReposListViewController: UIViewController {
    
    //MARK: Properties
    lazy var presenter: ReposListPresenter = {
        DiContainer.instance.resolveReposListPresenter()
    }()
    let searchController = UISearchController(searchResultsController: nil)

    //MARK: Outlets
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
        }
    }
    @IBOutlet weak var networkErrorView: NetworkErrorView! {
        didSet {
            networkErrorView.delegate = presenter
        }
    }
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.attach(view: self)
        registerTableViewCells()
        setupSearchController()
    }
    
    private func registerTableViewCells(){
        tableView.registerCellFromNib(named: ReposListCell.identifier)
    }

    private func setupSearchController(){
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Repos"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
}
extension ReposListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        // TODO
        let searchBar = searchController.searchBar
        print(searchBar.text)
    }
}

extension ReposListViewController: ReposListView {
    
    func didFailLoadingData(withErrorMsg errorMsg: String) {
        networkErrorView.isHidden = false
    }
    
}

extension ReposListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        12
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ReposListCell.identifier, for: indexPath) as? ReposListCell
        
        return cell!
    }
    
    
}

