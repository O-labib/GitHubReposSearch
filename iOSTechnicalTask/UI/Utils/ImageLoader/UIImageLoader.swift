//
//  UIImageLoader.swift
//  iOSTechnicalTask
//
//  Created by mac on 3/6/21.
//

import UIKit

class UIImageLoader {
    static let shared = UIImageLoader()

    private let imageLoader = ImageLoader()
    private var runningTasksMap = [UIImageView: UUID]()

    private init() {}

    func load(_ url: String?, into imageView: UIImageView) {
        imageView.image = UIImage(named: "avatarPlaceHolder")

        let taskUuid = imageLoader.loadImage(url) { result in
            defer { self.runningTasksMap.removeValue(forKey: imageView) }
            do {
                let image = try result.get()
                DispatchQueue.main.async {
                    imageView.image = image
                }
            } catch {
                DispatchQueue.main.async {
                    imageView.image = UIImage(named: "imageNotFound")
                }
            }
        }

        if let taskUuid = taskUuid {
            runningTasksMap[imageView] = taskUuid
        }
    }

    func cancel(for imageView: UIImageView) {
        if let taskUuid = runningTasksMap[imageView] {
            imageLoader.cancelLoad(taskUuid)
            runningTasksMap.removeValue(forKey: imageView)
        }
    }
}
