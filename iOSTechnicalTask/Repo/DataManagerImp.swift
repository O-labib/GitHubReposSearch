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
    
    private var allRepos: [GithubRepoModel]?
}
extension DataManagerImp: DataManager {
    
    func getRepos(containing searchQuery: String?) -> Observable<[GithubRepoModel]> {
        
        return Observable.create { observer in
            //MARK: create URLSession dataTask
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
                    //MARK: observer onNext event
                    observer.onError(error)
                }
                //MARK: observer onCompleted event
                observer.onCompleted()
            }
            task.resume()
            //MARK: return our disposable
            return Disposables.create {
                task.cancel()
            }
        }
    }
    
    func getAllReposIfEmptySearchQuery(searchQuery: String?) -> Observable<[GithubRepoModel]> {
        guard allRepos == nil else {
            return Observable.just(allRepos!)
        }
        fatalError()
    }
}
