//
//  DataManagerImp.swift
//  iOSTechnicalTask
//
//  Created by mac on 3/5/21.
//

import Foundation
import RxSwift

class DataManagerImp {
    private var allRepos: [GithubRepoModel]?
}

extension DataManagerImp: DataManager {

    func getRepos(containing searchQuery: String?, with paginationInput: PaginationInput) -> Observable<PaginatedRepos> {
            getAllRepos()
            .filtered(forTitlesContaining: searchQuery)
            .paginated(with: paginationInput)
    }

    private func getAllRepos() -> Observable<[GithubRepoModel]> {
        guard allRepos == nil else {
            return Observable.just(allRepos!)
        }
        return fetchAndCacheAllReposFromApi()
    }
    private func fetchAndCacheAllReposFromApi() -> Observable<[GithubRepoModel]> {
        return NetworkingHelper.fetchAllReposFromApi { (repos) in
            self.allRepos = repos
        }
    }
}

fileprivate extension Observable where Element == [GithubRepoModel] {
    func filtered(forTitlesContaining searchQuery: String?) -> Observable<[GithubRepoModel]> {
        map({ (allRepos) -> [GithubRepoModel] in
            guard searchQuery != nil && searchQuery != "" else {
                return allRepos
            }
            return allRepos
                .filter({$0
                            .title?
                            .lowercased()
                            .contains(searchQuery!.lowercased()) == true})
        })
    }

    func paginated(with paginationInput: PaginationInput) -> Observable<PaginatedRepos> {
        flatMap { (repos) -> Observable<PaginatedRepos> in
            return PaginationHelper.shared.getPaginatedRepos(with: paginationInput,
                                                           from: repos)
        }
    }
}
