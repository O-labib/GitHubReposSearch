//
//  ReposListPresenterImp.swift
//  iOSTechnicalTask
//
//  Created by mac on 3/4/21.
//

import Foundation
import RxSwift

class ReposListPresenterImp: ReposListPresenter {

    private let dataManager: DataManager
    private var view: ReposListView?
    private let disposeBag = DisposeBag()
    private var latestPageInfo: PaginationInfo?
    private var latestSearchQuery: String?

    init(dataManager: DataManager) {
        self.dataManager = dataManager
    }

    func attach(view: ReposListView) {
        self.view = view
    }
    func detachView() {
        self.view = nil
    }

    // MARK: Initial Request
    func getRepos(containing searchQuery: String? = nil) {
        view?.showLoader()

        let adjustedSearchQuery = refineAndCacheSearchQuery(searchQuery)

        dataManager.getRepos(containing: adjustedSearchQuery,
                             with: .firstPage)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] (result) in
                let repos = result.repos
                self?.latestPageInfo = result.paginationInfo
                self?.view?.reposWereLoaded(repos)

            }, onError: { [weak self] (error) in
                self?.view?.didFailLoadingRepos(withErrorMsg: error.localizedDescription)

            }, onCompleted: { [weak self] in
                self?.view?.hideLoader()

            }).disposed(by: disposeBag)
    }
    private func refineAndCacheSearchQuery(_ searchQuery: String?) -> String? {
        let refinedSearchQuery = refineSearchQueryIfTooShort(searchQuery)
        self.latestSearchQuery = refinedSearchQuery
        return refinedSearchQuery
    }
    private func refineSearchQueryIfTooShort(_ searchQuery: String?) -> String? {
        return (searchQuery?.count ?? 0) < 2 ? nil : searchQuery
    }

    // MARK: Pagination
    func paginateRepos() {
        guard latestPageInfo?.hasNext != false else { return }

        dataManager.getRepos(containing: latestSearchQuery,
                             with: latestPageInfo!.nextPageInput)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] (result) in
                let repos = result.repos
                self?.latestPageInfo = result.paginationInfo
                self?.view?.reposWerePaginated(newRepos: repos)

            }, onError: { [weak self] (error) in
                self?.view?.didFailLoadingRepos(withErrorMsg: error.localizedDescription)

            }, onCompleted: { [weak self] in
                self?.view?.hideLoader()

            }).disposed(by: disposeBag)
    }

}

// MARK: NetworkErrorView Delegate
extension ReposListPresenterImp: NetworkErrorViewDelegate {

    func networkErrorViewDidTapRetry(_ networkErrorView: NetworkErrorView) {
        self.getRepos(containing: latestSearchQuery)
    }

}

extension String {
    static let any: String? = nil
}
