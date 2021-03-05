//
//  DataManager.swift
//  iOSTechnicalTask
//
//  Created by mac on 3/5/21.
//

import Foundation
import RxSwift

protocol DataManager {
    func getRepos(containing searchQuery: String?, with paginationInput: PaginationInput) -> Observable<PaginatedRepos>
}
