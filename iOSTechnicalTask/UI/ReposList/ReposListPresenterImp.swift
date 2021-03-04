//
//  ReposListPresenterImp.swift
//  iOSTechnicalTask
//
//  Created by mac on 3/4/21.
//

import Foundation

class ReposListPresenterImp:  ReposListPresenter {
    
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
