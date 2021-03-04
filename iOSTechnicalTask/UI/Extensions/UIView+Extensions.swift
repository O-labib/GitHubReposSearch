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
}

extension UITableView {
    func registerCellFromNib(named nibFileName: String,
                             atBundle bundle: Bundle? = nil) {
        register(UINib(nibName: nibFileName, bundle: bundle),
                 forCellReuseIdentifier: nibFileName)
    }
}
