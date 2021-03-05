//
//  NoSearchResultsCell.swift
//  iOSTechnicalTask
//
//  Created by mac on 3/4/21.
//

import UIKit

class NoResultsCell: UITableViewCell {

    //MARK: Functions
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        
    }
}

//MARK: Delegate

protocol NoSearchResultsCellDelegate {
    
}
