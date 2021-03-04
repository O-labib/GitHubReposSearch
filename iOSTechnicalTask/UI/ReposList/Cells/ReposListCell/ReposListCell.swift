//
//  ReposListCell.swift
//  iOSTechnicalTask
//
//  Created by mac on 3/4/21.
//

import UIKit

// MARK: Delegate
protocol ReposListCellDelegate: class {
    
}
class ReposListCell: UITableViewCell {

    //MARK: Properties
    weak var delegate: ReposListCellDelegate?
    
    //MARK: Outlets
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var repoTitleLabel: UILabel!
    @IBOutlet weak var repoOwnerNameLabel: UILabel!
    @IBOutlet weak var repoCreationDateLabel: UILabel!
    
    //MARK: Functions
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        avatarImageView.backgroundColor = .orange
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        avatarImageView.setCircular()
    }
}


