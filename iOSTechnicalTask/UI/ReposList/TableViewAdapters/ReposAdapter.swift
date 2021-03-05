//
//  ResultsAdapter.swift
//  iOSTechnicalTask
//
//  Created by mac on 3/5/21.
//

import UIKit

class ReposAdapter: BaseAdapter {
    
    var repos: [GithubRepoModel]
    init(repos: [GithubRepoModel]) {
        self.repos = repos
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        repos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ReposListCell.identifier, for: indexPath) as? ReposListCell ?? ReposListCell()
        cell.bindWith(repo: repos[indexPath.row])
        return cell
    }
    
}
