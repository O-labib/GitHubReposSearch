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
    var tableViewAdapter = BaseAdapter()
    //MARK: Outlets
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.prefetchDataSource = self
            tableView.delegate = self
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
        navigationItem.title = "GitHub Repos"

        presenter.getRepos(containing: .any)
    }
    
    private func registerTableViewCells(){
        tableView.registerCellFromNib(named: ReposListCell.identifier)
        tableView.registerCellFromNib(named: NoResultsCell.identifier)
    }

    
}

extension ReposListViewController: ReposListView {
    func reposWerePaginated(newRepos: [GithubRepoModel]) {
        (tableViewAdapter as? ReposAdapter)?.appendReposUponPagination(newRepos)
        tableView.insertNewlyPaginatedData(newRepos)
    }

    func showLoader() {
        activityIndicator.startAnimating()
    }
    
    func hideLoader() {
        activityIndicator.stopAnimating()
    }

    func reposWereLoaded(_ repos: [GithubRepoModel]) {
        updateTableViewForResults(repos)
        showEmptyCellIfNoResults(repos)
        
        setupSearchController()
        
        tableView.reveal()
        networkErrorView.hide()
    }
    private func updateTableViewForResults(_ repos: [GithubRepoModel]){
        guard repos.isEmpty == false else { return }
        tableViewAdapter = ReposAdapter(repos: repos,
                                        delegate: self)
        tableView.reloadSections([0], with: .fade)
    }
    private func showEmptyCellIfNoResults(_ repos: [GithubRepoModel]){
        guard repos.isEmpty else { return }
        
        let emptyCellIsAlreadyShown = tableView.cellForRow(at: .init(row: 0,
                                                                     section: 0)) as? NoResultsCell != nil
        if emptyCellIsAlreadyShown {
            return
        }
        tableViewAdapter = NoResultsAdapter()
        tableView.reloadSections([0], with: .fade)
    }
    private func setupSearchController(){
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Repos"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    func didFailLoadingRepos(withErrorMsg errorMsg: String?) {
        tableView.hide()
        networkErrorView.reveal()
        networkErrorView.setErrorMsg(errorMsg)
    }
    
}
extension ReposListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        presenter.getRepos(containing: searchBar.text)
    }
}
extension ReposListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableViewAdapter.tableView(tableView, numberOfRowsInSection: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableViewAdapter.tableView(tableView, cellForRowAt: indexPath)
    }
    
}
extension ReposListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableViewAdapter.tableView(tableView, didSelectRowAt: indexPath)
    }
}
extension ReposListViewController: UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        tableViewAdapter.tableView(tableView, prefetchRowsAt: indexPaths)
    }
    
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        let repoCells = indexPaths.compactMap({tableView.cellForRow(at: $0) as? ReposListCell})
        repoCells.forEach({
            $0.cancelImageLoadingTask()
        })
    }
    
}
extension ReposListViewController: ReposAdapterDelegate {
    
    func repoWasSelected(_ repo: GithubRepoModel) {
        let repoDetailsVc = RepoDetailsViewController.createFromStoryboard(with: repo)
        navigationController?.pushViewController(repoDetailsVc, animated: true)
    }
   
    func tableViewNeedsToPaginateRepos() {
        presenter.paginateRepos()
    }

}
