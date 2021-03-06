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

extension Observable where Element == [GithubRepoModel] {
    func filtered(forTitlesContaining searchQuery: String?) -> Observable<[GithubRepoModel]> {
        map({ (allRepos) -> [GithubRepoModel] in
            allRepos.filtered(forTitlesContaining: searchQuery)
        })
    }

    func paginated(with paginationInput: PaginationInput) -> Observable<PaginatedRepos> {
        map { (repos) -> PaginatedRepos in
            repos.paginated(with: paginationInput)
        }
    }
}
extension Array where Element == GithubRepoModel {
    func filtered(forTitlesContaining searchQuery: String?) -> [GithubRepoModel] {
            guard searchQuery != nil && searchQuery != "" else {
                return self
            }
            return self
                .filter({$0
                            .title?
                            .lowercased()
                            .contains(searchQuery!.lowercased()) == true})
        }
    func paginated(with paginationInput: PaginationInput) -> PaginatedRepos {
        PaginationHelper.shared.getPaginatedRepos(with: paginationInput,
                                                  from: self)
    }
}
