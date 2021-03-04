//
//  ReposListContract.swift
//  iOSTechnicalTask
//
//  Created by mac on 3/4/21.
//

import Foundation

protocol ReposListView {
}
protocol ReposListPresenter {
    func attach(view: ReposListView)
    func detachView()
}
