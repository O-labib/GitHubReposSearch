//
//  ReposListPresenterImp.swift
//  iOSTechnicalTask
//
//  Created by mac on 3/4/21.
//

import Foundation
import RxSwift

class ReposListPresenterImp:  ReposListPresenter {
    
    var dataManager: DataManager
    let disposeBag = DisposeBag()
    
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
        dataManager.getRepos(containing: searchQuery, with: PaginationInput(page: 24, itemsPerPage: 4))
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] (repos) in
                self?.view?.reposWereLoaded(repos.repos)
            }, onError: { [weak self] (error) in
                self?.view?.didFailLoadingRepos(withErrorMsg: error.localizedDescription)
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
