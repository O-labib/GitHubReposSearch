//
//  ReposListContract.swift
//  iOSTechnicalTask
//
//  Created by mac on 3/4/21.
//

import Foundation

protocol ReposListView {
    func didFailLoadingRepos(withErrorMsg errorMsg: String?)
    func reposWereLoaded(_ repos: [GithubRepoModel])
    func showLoader()
    func hideLoader()
}
protocol ReposListPresenter: NetworkErrorViewDelegate {
    func attach(view: ReposListView)
    func detachView()
    func getRepos(containing searchQuery: String?)
}
