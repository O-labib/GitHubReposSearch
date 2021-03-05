//
//  RepoDetailsViewController.swift
//  iOSTechnicalTask
//
//  Created by mac on 3/5/21.
//

import UIKit

class RepoDetailsViewController: UIViewController {

    static func createFromStoryboard(with repo: GithubRepoModel) -> RepoDetailsViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "RepoDetailsViewController") as!RepoDetailsViewController
        vc.repo = repo
        return vc
    }
    var repo: GithubRepoModel!
    @IBOutlet weak var repoTitleLabel: UILabel!
    @IBOutlet weak var repoOwnerAvatarImageView: UIImageView!
    @IBOutlet weak var repoDescriptionLabel: UILabel!
    @IBOutlet weak var repoOwnerNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewToRepoDetails()
    }
    
    private func bindViewToRepoDetails() {
        guard repo != nil else { return }
        
        repoTitleLabel.text = repo.title
        navigationItem.title = repo.title
        repoDescriptionLabel.text = repo.description
        repoOwnerNameLabel.text = repo.owner?.name
    }

}
