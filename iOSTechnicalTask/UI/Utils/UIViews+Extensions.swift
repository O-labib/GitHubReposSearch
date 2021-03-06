//
//  UIImageView+Extensions.swift
//  iOSTechnicalTask
//
//  Created by mac on 3/4/21.
//

import UIKit

extension NSObject {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UIView {
    func setCircular() {
        self.clipsToBounds = true
        self.layer.cornerRadius = bounds.height / 2
        self.layer.masksToBounds = true
    }
    func hide() {
        isHidden = true
    }
    func reveal() {
        isHidden = false
    }
}

extension UITableView {
    func registerCellFromNib(named nibFileName: String,
                             atBundle bundle: Bundle? = nil) {
        register(UINib(nibName: nibFileName, bundle: bundle),
                 forCellReuseIdentifier: nibFileName)
    }
    func insertNewlyPaginatedData(_ data: [Any]) {
        guard data.isEmpty == false else { return }

        var lastRowIndex = numberOfRows(inSection: 0) - 1
        var newIndices: [IndexPath] = []
        
        for _ in 0..<data.count {
            lastRowIndex += 1
            newIndices.append(IndexPath(row: lastRowIndex, section: 0))
        }
        
        insertRows(at: newIndices, with: .none)
    }
}
extension UIImageView {
    func loadImage(at url: String?) {
        UIImageLoader.shared.load(url, into: self)
    }
    
    func cancelImageLoad() {
        UIImageLoader.shared.cancel(for: self)
    }
}
