//
//  CircularImageView.swift
//  iOSTechnicalTask
//
//  Created by mac on 3/6/21.
//

import UIKit

@IBDesignable class CircularImageView: UIImageView {

    override func layoutSubviews() {
        super.layoutSubviews()
        setCircular()
    }

}
