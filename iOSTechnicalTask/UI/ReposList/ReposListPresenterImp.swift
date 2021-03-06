//
//  ReposListPresenterImp.swift
//  iOSTechnicalTask
//
//  Created by mac on 3/4/21.
//

import Foundation
import RxSwift

class ReposListPresenterImp: ReposListPresenter {

    var dataManager: DataManager
    let disposeBag = DisposeBag()
    var latestPageInfo: PaginationInfo?
    var latestSearchQuery: String?

    init(dataManager: DataManager) {
        self.dataManager = dataManager
    }
    var view: ReposListView?
    func attach(view: ReposListView) {
        self.view = view
    }
    func detachView() {
        self.view = nil
    }

    func getRepos(containing searchQuery: String? = nil) {
        view?.showLoader()

        let adjustedSearchQuery = adjustSearchQueryIfTooShort(searchQuery)
        self.latestSearchQuery = adjustedSearchQuery

        dataManager.getRepos(containing: adjustedSearchQuery,
                             with: PaginationInput(page: 0))
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
    func adjustSearchQueryIfTooShort(_ searchQuery: String?) -> String? {
        return (searchQuery?.count ?? 0) < 2 ? nil : searchQuery
    }

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

extension ReposListPresenterImp: NetworkErrorViewDelegate {

    func networkErrorViewDidTapRetry(_ networkErrorView: NetworkErrorView) {
        self.getRepos(containing: .any)
    }

}

extension String {
    static let any: String? = nil
}
