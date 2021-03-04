//
//  ReposListViewController.swift
//  iOSTechnicalTask
//
//  Created by mac on 3/4/21.
//

import UIKit

class ReposListViewController: UIViewController {
    
    lazy var presenter: ReposListPresenter = {
        DiContainer.instance.resolveReposListPresenter()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.attach(view: self)
    }
    

}

extension ReposListViewController: ReposListView {
    
}
