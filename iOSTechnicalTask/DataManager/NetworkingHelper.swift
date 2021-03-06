//
//  NetworkingHelper.swift
//  iOSTechnicalTask
//
//  Created by mac on 3/6/21.
//

import Foundation
import RxSwift

class NetworkingHelper {
    private static let url = "https://api.github.com/repositories"
    private static let urlSession = URLSession.shared
    private static let jsonDecoder = JSONDecoder()

    static func fetchAllReposFromApi(success : @escaping  ([GithubRepoModel]) -> Void) -> Observable<[GithubRepoModel]> {
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
                        success(repos)
                        observer.onNext(repos)
                    } else {
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
}
