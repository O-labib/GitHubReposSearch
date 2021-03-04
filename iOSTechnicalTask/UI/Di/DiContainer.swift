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
    func resolveReposListPresenter() -> ReposListPresenter {
        return ReposListPresenterImp()
    }
}
