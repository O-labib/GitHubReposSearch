//
//  ReposListContract.swift
//  iOSTechnicalTask
//
//  Created by mac on 3/4/21.
//

import Foundation

protocol ReposListView {
    func didFailLoadingData(withErrorMsg errorMsg: String)
}
protocol ReposListPresenter: NetworkErrorViewDelegate {
    func attach(view: ReposListView)
    func detachView()
}
