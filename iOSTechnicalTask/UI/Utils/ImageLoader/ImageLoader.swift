//
//  ImageLoader.swift
//  iOSTechnicalTask
//
//  Created by mac on 3/6/21.
//

import UIKit
class ImageLoader {
    private let cachedImages = NSCache<NSURL, UIImage>()
    private var runningLoadingTasks = [UUID: URLSessionDataTask]()

    func loadImage(_ urlString: String?,
                   _ completion: @escaping (Result<UIImage, Error>) -> Void) -> UUID? {

        guard urlString != nil,
              let imageURL = URL(string: urlString!),
              let imageNSURL = NSURL(string: urlString!) else { return nil }

        if let cachedImage = cachedImages.object(forKey: imageNSURL) {
            completion(.success(cachedImage))
            return nil
        }

        let loadingTaskUuid = UUID()

        let task = URLSession.shared.dataTask(with: imageURL) { data, _, error in
            defer { self.runningLoadingTasks.removeValue(forKey: loadingTaskUuid) }

            if let data = data, let image = UIImage(data: data) {
                self.cachedImages.setObject(image, forKey: imageNSURL)
                completion(.success(image))
                return
            }

            if let error = error, (error as NSError).code != NSURLErrorCancelled {
                completion(.failure(error))
            }

        }
        task.resume()

        runningLoadingTasks[loadingTaskUuid] = task
        return loadingTaskUuid
    }

    func cancelLoad(_ uuid: UUID) {
        runningLoadingTasks[uuid]?.cancel()
        runningLoadingTasks.removeValue(forKey: uuid)
    }
}
