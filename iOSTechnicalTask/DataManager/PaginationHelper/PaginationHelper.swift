//
//  PaginationHelper.swift
//  iOSTechnicalTask
//
//  Created by mac on 3/5/21.
//

import Foundation
import RxSwift

class PaginationHelper {
    private init() {}
    static let shared = PaginationHelper()
    func getPaginatedRepos(with paginationInput: PaginationInput, from allRepos: [GithubRepoModel]) -> Observable<PaginatedRepos> {

        let repoPages = allRepos.dividedIntoPages(ofSize: paginationInput.itemsPerPage)
        guard repoPages.count > paginationInput.page else {
            let paginationResult = PaginationInfo(currentPage: paginationInput.page,
                                                  itemsPerPage: paginationInput.itemsPerPage,
                                                  totalPagesCount: repoPages.count,
                                                  hasNext: false)
            return Observable.just(PaginatedRepos(repos: [],
                                                  paginationInfo: paginationResult))
        }

        let reposForSelectedPage = repoPages[paginationInput.page]
        let paginationInfo = PaginationInfo(currentPage: paginationInput.page,
                                            itemsPerPage: paginationInput.itemsPerPage,
                                            totalPagesCount: repoPages.count,
                                            hasNext: paginationInput.page < repoPages.count - 1)

        return Observable.just(PaginatedRepos(repos: reposForSelectedPage, paginationInfo: paginationInfo))
    }
}

extension Array {
    func dividedIntoPages(ofSize size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}
