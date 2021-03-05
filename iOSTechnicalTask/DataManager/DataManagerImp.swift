//
//  DataManagerImp.swift
//  iOSTechnicalTask
//
//  Created by mac on 3/5/21.
//

import Foundation
import RxSwift

class DataManagerImp {
    private let url = "https://api.github.com/repositories"
    private let urlSession = URLSession.shared
    private let jsonDecoder = JSONDecoder()
    private let paginationHelper = PaginationHelper.shared
    private var allRepos: [GithubRepoModel]?
}
extension DataManagerImp: DataManager {
    
    func getRepos(containing searchQuery: String?, with paginationInput: PaginationInput) -> Observable<PaginatedRepos> {
        getAllRepos()
            .map({ (allRepos) -> [GithubRepoModel] in
                return self.filterRepos(allRepos, forTitlesContaining: searchQuery)
            })
            .flatMap { (repos) -> Observable<PaginatedRepos> in
                return self.paginationHelper.getPaginatedRepos(with: paginationInput,
                                                                 from: repos)
            }
    }
    
    private func getAllRepos() -> Observable<[GithubRepoModel]> {
        guard allRepos == nil else {
            return Observable.just(allRepos!)
        }
        return fetchAllReposFromApi()
    }
    private func fetchAllReposFromApi() -> Observable<[GithubRepoModel]> {
        return Observable.create { observer in
            let task = self.urlSession.dataTask(with: URL(string: self.url)!) { (data,
                                                                                 response, error) in
                guard
                    let data = data,
                    let httpResponse = response as? HTTPURLResponse,
                    error == nil else {
                    observer.onError(error!)
                    observer.onCompleted()
                    return
                }
                do {
                    if httpResponse.statusCode == 200 {
                        let repos = try self.jsonDecoder.decode([GithubRepoModel].self,
                                                                from: data)
                        self.allRepos = repos
                        observer.onNext(repos)
                    }
                    else {
                        observer.onError(error!)
                    }
                } catch {
                    observer.onError(error)
                }
                observer.onCompleted()
            }
            task.resume()
            return Disposables.create {
                task.cancel()
            }
        }
    }
    private func filterRepos(_ repos: [GithubRepoModel], forTitlesContaining searchQuery: String?) -> [GithubRepoModel] {
        return repos.filter({$0.title?.contains(searchQuery ?? "") == true})
    }
}

