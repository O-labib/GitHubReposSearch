//
//  ResultsAdapter.swift
//  iOSTechnicalTask
//
//  Created by mac on 3/5/21.
//

import UIKit

// MARK: ReposAdapter Delegate
protocol ReposAdapterDelegate: class {
    func tableViewNeedsToPaginateRepos()
    func repoWasSelected(_ repo: GithubRepoModel)
}

class ReposAdapter: BaseAdapter {

    private var repos: [GithubRepoModel]
    private weak var delegate: ReposAdapterDelegate?
    private var isPaginating = false

    init(repos: [GithubRepoModel], delegate: ReposAdapterDelegate) {
        self.repos = repos
        self.delegate = delegate
    }

    // MARK: DataSource Functions
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        repos.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ReposListCell.identifier, for: indexPath) as? ReposListCell ?? ReposListCell()
        cell.bindWith(repo: repos[indexPath.row])
        return cell
    }

    // MARK: Delegate Functions
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let repo = repos[indexPath.row]
        delegate?.repoWasSelected(repo)
    }

    // MARK: PrefetchDelegate Functions
    override func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for index in indexPaths where index.row == repos.count - 6 && !isPaginating {
            isPaginating = true
            self.delegate?.tableViewNeedsToPaginateRepos()
            break
        }
    }
}

extension ReposAdapter {

    func appendReposUponPagination(_ repos: [GithubRepoModel]) {
        isPaginating = false
        self.repos.append(contentsOf: repos)
    }
}
