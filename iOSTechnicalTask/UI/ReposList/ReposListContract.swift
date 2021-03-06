//
//  ReposListContract.swift
//  iOSTechnicalTask
//
//  Created by mac on 3/4/21.
//

import Foundation

protocol ReposListView {
    func showLoader()
    func hideLoader()
    func reposWereLoaded(_ repos: [GithubRepoModel])
    func reposWerePaginated(newRepos: [GithubRepoModel])
    func didFailLoadingRepos(withErrorMsg errorMsg: String?)
}

protocol ReposListPresenter: NetworkErrorViewDelegate {
    func attach(view: ReposListView)
    func detachView()
    func getRepos(containing searchQuery: String?)
    func paginateRepos()
}
