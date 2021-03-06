//
//  RepoDetailsViewController.swift
//  iOSTechnicalTask
//
//  Created by mac on 3/5/21.
//

import UIKit

class RepoDetailsViewController: UIViewController {

    // MARK: Creator
    static func createFromStoryboard(with repo: GithubRepoModel) -> RepoDetailsViewController {
        let storyboard = UIStoryboard.main
        let vc = storyboard.instantiateViewController(withIdentifier: self.identifier) as! RepoDetailsViewController
        vc.repo = repo
        return vc
    }

    @IBOutlet weak var repoTitleLabel: UILabel!
    @IBOutlet weak var repoOwnerAvatarImageView: CircularImageView!
    @IBOutlet weak var repoDescriptionLabel: UILabel!
    @IBOutlet weak var repoOwnerNameLabel: UILabel!

    private var repo: GithubRepoModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewToRepoDetails()
    }

    private func bindViewToRepoDetails() {
        guard repo != nil else { return }

        repoTitleLabel.text = repo.title
        navigationItem.title = repo.title
        repoOwnerAvatarImageView.loadImage(from: repo.owner?.avatarImageUrl)
        repoDescriptionLabel.text = repo.description
        repoOwnerNameLabel.text = repo.owner?.name
    }

}

extension UIStoryboard {
    static var main: UIStoryboard {
        UIStoryboard(name: "Main", bundle: nil)
    }
}
