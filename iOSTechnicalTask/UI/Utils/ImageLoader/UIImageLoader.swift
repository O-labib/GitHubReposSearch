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
    private var runningTasks = [UIImageView: UUID]()

    private init() {}

    func load(from url: String?, into imageView: UIImageView) {
        setDefaultPlaceHolder(onImage: imageView)
        loadImageAndSaveTaskIfSuccess(from: url, into: imageView)
    }

    private func setDefaultPlaceHolder(onImage imageView: UIImageView) {
        imageView.image = .avatarPlaceHolder
    }

    private func loadImageAndSaveTaskIfSuccess(from url: String?, into imageView: UIImageView) {
        let taskUuid = imageLoader.loadImage(from: url) { result in
            defer { self.runningTasks.removeValue(forKey: imageView) }
            do {
                let image = try result.get()
                DispatchQueue.main.async {
                    imageView.image = image
                }
            } catch {
                DispatchQueue.main.async {
                    imageView.image = .imageNotFound
                }
            }
        }

        if let taskUuid = taskUuid {
            runningTasks[imageView] = taskUuid
        }
    }

    func cancel(for imageView: UIImageView) {
        if let taskUuid = runningTasks[imageView] {
            imageLoader.cancelLoad(taskUuid)
            runningTasks.removeValue(forKey: imageView)
        }
    }
}

extension Optional where Wrapped: UIImage {
    static var avatarPlaceHolder: UIImage? {
        UIImage(named: "avatarPlaceHolder")
    }
    static var imageNotFound: UIImage? {
        UIImage(named: "imageNotFound")
    }
}
