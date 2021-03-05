//
//  DiContainer.swift
//  iOSTechnicalTask
//
//  Created by mac on 3/4/21.
//

import Foundation
class DiContainer {
    static var instance = DiContainer()
    private init () {}
    var dataManager = DataManagerImp()
    func resolveReposListPresenter() -> ReposListPresenter {
        return ReposListPresenterImp(dataManager: dataManager)
    }
}
