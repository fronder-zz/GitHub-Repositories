//
//  UserDetailsViewController.swift
//  GitHub Repositories
//
//  Created by Hasan on 7/26/19.
//  Copyright © 2019 Hasan. All rights reserved.
//

import UIKit

class UserDetailsViewController: UIViewController {

    // MARK: - Variables
    
    lazy var imageView: UIImageView = {
        let layer = UIImageView()
        
        return layer
    }()
    lazy var closeButton: UIButton = {
        let layer = UIButton()
        layer.setTitle("Close", for: .normal)
        layer.addTarget(self, action: #selector(closeDidClick), for: .touchUpInside)
        layer.setTitleColor(.blue, for: .normal)
        layer.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        
        return layer
    }()
    lazy var nameLabel: UILabel = {
        let layer = UILabel()
        layer.text = "Author name:"
        
        return layer
    }()
    lazy var userNameLabel: UILabel = {
        let layer = UILabel()
        layer.font = UIFont.boldSystemFont(ofSize: 20)
        
        return layer
    }()
    fileprivate var viewModel: UserDetailViewModel!
    
    
    // MARK: - Lifecycle
    
    convenience init(with userDetailsViewModel: UserDetailViewModel) {
        self.init()
        
        self.viewModel = userDetailsViewModel
        
        setup()
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = viewModel.backgroundColor
        
        imageView.image = viewModel.image
        userNameLabel.text = viewModel.name
    }
    

    // MARK: - Private
    
    fileprivate func setup() {
        view.addSubview(imageView)
        view.addSubview(closeButton)
        view.addSubview(nameLabel)
        view.addSubview(userNameLabel)
        
        closeButton.snp.makeConstraints { (make) in
            make.top.equalTo(30)
            make.right.equalTo(-8)
            make.height.equalTo(50)
            make.width.greaterThanOrEqualTo(10)
        }
        imageView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(300)
        }
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(imageView.snp.bottom).offset(8)
            make.left.equalTo(16)
            make.width.equalTo(120)
            make.height.equalTo(21)
        }
        userNameLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(nameLabel)
            make.left.equalTo(nameLabel.snp.right).offset(8)
            make.right.equalTo(-8)
            make.height.equalTo(21)
        }
    }
    
    @objc fileprivate func closeDidClick() {
        dismiss(animated: true)
    }

}
