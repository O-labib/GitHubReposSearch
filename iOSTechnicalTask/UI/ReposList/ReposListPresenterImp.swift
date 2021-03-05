//
//  ReposListPresenterImp.swift
//  iOSTechnicalTask
//
//  Created by mac on 3/4/21.
//

import Foundation

class ReposListPresenterImp:  ReposListPresenter {
    
    var dataManager: DataManager
    
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
}

extension ReposListPresenterImp: NetworkErrorViewDelegate {
    
    func networkErrorViewDidTapRetry(_ networkErrorView: NetworkErrorView) {

    }
    
}
