//
//  ResultsAdapter.swift
//  iOSTechnicalTask
//
//  Created by mac on 3/5/21.
//

import UIKit
protocol ReposAdapterDelegate: class {
    func tableViewNeedsToPaginateRepos()
    func repoWasSelected(_ repo: GithubRepoModel)
}
class ReposAdapter: BaseAdapter {

    var repos: [GithubRepoModel]
    weak var delegate: ReposAdapterDelegate?

    var isPaginating = false

    init(repos: [GithubRepoModel], delegate: ReposAdapterDelegate) {
        self.repos = repos
        self.delegate = delegate
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        repos.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ReposListCell.identifier, for: indexPath) as? ReposListCell ?? ReposListCell()
        cell.bindWith(repo: repos[indexPath.row])
        return cell
    }

    func appendReposUponPagination(_ repos: [GithubRepoModel]) {
        isPaginating = false
        self.repos.append(contentsOf: repos)
    }

    override func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for index in indexPaths where index.row == repos.count - 6 && !isPaginating {
            isPaginating = true
            self.delegate?.tableViewNeedsToPaginateRepos()
            break
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let repo = repos[indexPath.row]
        delegate?.repoWasSelected(repo)
    }
}
