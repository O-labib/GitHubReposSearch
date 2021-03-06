//
//  ReposListCell.swift
//  iOSTechnicalTask
//
//  Created by mac on 3/4/21.
//

import UIKit

class ReposListCell: UITableViewCell {

    // MARK: Outlets
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var repoTitleLabel: UILabel!
    @IBOutlet weak var repoOwnerNameLabel: UILabel!
    @IBOutlet weak var repoCreationDateLabel: UILabel!

    // MARK: System Functions
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        avatarImageView.setCircular()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        avatarImageView.cancelImageLoad()
    }
}
// MARK: Exposed Functions
extension ReposListCell {

    func bindWith(repo: GithubRepoModel) {
        repoTitleLabel.text = repo.title
        repoOwnerNameLabel.text = repo.owner?.name
        avatarImageView.loadImage(from: repo.owner?.avatarImageUrl)
    }

    func cancelImageLoadingTask() {
        avatarImageView.cancelImageLoad()
    }
}
