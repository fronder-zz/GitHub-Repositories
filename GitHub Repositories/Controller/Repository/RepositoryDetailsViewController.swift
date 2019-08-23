//
//  RepositoryDetailsViewController.swift
//  GitHub Repositories
//
//  Created by Hasan on 7/26/19.
//  Copyright © 2019 Hasan. All rights reserved.
//

import UIKit

class RepositoryDetailsViewController: BaseViewController {

    // MARK: - IBOutlets
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var forksLabel: UILabel!
    @IBOutlet weak var watchersLabel: UILabel!
    @IBOutlet weak var urlLabel: UILabel!
    
    
    // MARK: - Variables
    
    var viewModel: RepositoryDetailViewModel!
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabel.text = viewModel.name
        fullNameLabel.text = viewModel.fullName
        descriptionLabel.text = viewModel.description
        languageLabel.text = viewModel.language
        forksLabel.text = viewModel.forksNumber
        watchersLabel.text = viewModel.watchers
        urlLabel.text = viewModel.htmlUrl
    }
   
    override class func instantiate() -> RepositoryDetailsViewController {
        return RepositoryDetailsViewController.instantiate(viewControllerIdentifier: String(describing: RepositoryDetailsViewController.self)) as! RepositoryDetailsViewController
    }

    
    // MARK: - Private
    
    @IBAction private func viewInBroserDidClick(_ sender: Any) {
        if let urlString = viewModel.htmlUrl {
            navigationController?.pushViewController(WebViewController(urlString: urlString), animated: true)
        }
    }
}
