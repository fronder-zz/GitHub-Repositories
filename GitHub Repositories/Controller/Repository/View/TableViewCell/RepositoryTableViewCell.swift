//
//  RepositoryTableViewCell.swift
//  GitHub Repositories
//
//  Created by Hasan on 7/25/19.
//  Copyright © 2019 Hasan. All rights reserved.
//

import UIKit

protocol RepositoryTableViewCellDelegate: class {
    func avatarImageViewDidSelect(with userDetailViewModel: UserDetailViewModel, cell: RepositoryTableViewCell)
    func cellDidClick(with repoDetailsViewModel: RepositoryDetailViewModel)
}

class RepositoryTableViewCell: BaseTableViewCell {
    
    // MARK: - Vaariables
    
    lazy var avatarImageView: UIImageView = {
        let layer = UIImageView()
        layer.image = UIImage(named: "placeholder")
        layer.layer.cornerRadius = 25
        layer.layer.masksToBounds = true
        
        return layer
    }()
    lazy var repoTitleLabel: UILabel = {
        let layer = UILabel()
        layer.font = UIFont.boldSystemFont(ofSize: 17)
        
        return layer
    }()
    lazy var authorNameLabel: UILabel = {
        let layer = UILabel()
        layer.font = UIFont.systemFont(ofSize: 13)
        layer.text = "author:"
        layer.textColor = .gray
        
        return layer
    }()
    lazy var authorLabel: UILabel = {
        let layer = UILabel()
        layer.font = UIFont.systemFont(ofSize: 13)
        layer.textAlignment = .left
        
        return layer
    }()
    lazy var forksNumberLabel: UILabel = {
        let layer = UILabel()
        layer.font = UIFont.systemFont(ofSize: 13)
        layer.text = "forks count:"
        layer.textColor = .gray
        
        return layer
    }()
    lazy var forksLabel: UILabel = {
        let layer = UILabel()
        layer.font = UIFont.systemFont(ofSize: 13)
        
        
        return layer
    }()
    lazy var languageNameLabel: UILabel = {
        let layer = UILabel()
        layer.font = UIFont.systemFont(ofSize: 13)
        layer.text = "language:"
        layer.textColor = .gray
        
        return layer
    }()
    lazy var languageLabel: UILabel = {
        let layer = UILabel()
        layer.font = UIFont.systemFont(ofSize: 13)
        
        return layer
    }()
    private var viewModel: RepositoryListCellViewModel!
    weak var delegate: RepositoryTableViewCellDelegate?

    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupLabels()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Public
    
    func setViewModel(with viewModel: RepositoryListCellViewModel) {
        repoTitleLabel.text = viewModel.name
        authorLabel.text = viewModel.authorName
        forksLabel.text = viewModel.forksNumber
        languageLabel.text = viewModel.language
        viewModel.setImageTo(imageView: avatarImageView)
        
        self.viewModel = viewModel
    }
    
    
    // MARK: -
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        guard let touch: UITouch = touches.first else { return }
        
        let location = touch.location(in: self)
        if avatarImageView.frame.contains(location) {
            avatarImageView.animateFor(isHighlighted: true)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        avatarImageView.animateFor(isHighlighted: false)
        
        guard let touch: UITouch = touches.first else { return }
        
        let location = touch.location(in: self)
        if avatarImageView.frame.contains(location) {
            delegate?.avatarImageViewDidSelect(with: UserDetailViewModel(with: viewModel.repo.user, image: avatarImageView.image!), cell: self)
        } else {
            let repoViewModel = RepositoryDetailViewModel(authorName: viewModel.authorName!,
                                                          forksNumber: viewModel.forksNumber!,
                                                          language: viewModel.language!,
                                                          repoName: viewModel.name!,
                                                          repo: viewModel.repo)
            
            delegate?.cellDidClick(with: repoViewModel)
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        avatarImageView.animateFor(isHighlighted: false)
    }
    
    
    // MARK: - Private
    // Setup UI views in code with help of magic SnapKit
    private func setupLabels() {
        contentView.addSubview(avatarImageView)
        contentView.addSubview(repoTitleLabel)
        contentView.addSubview(authorNameLabel)
        contentView.addSubview(authorLabel)
        contentView.addSubview(forksNumberLabel)
        contentView.addSubview(forksLabel)
        contentView.addSubview(languageNameLabel)
        contentView.addSubview(languageLabel)
        
        avatarImageView.snp.makeConstraints { (make) in
            make.left.equalTo(8)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(50)
        }
        repoTitleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(avatarImageView.snp.right).offset(8)
            make.top.equalTo(8)
            make.right.equalTo(-8)
            make.height.equalTo(25)
        }
        authorNameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(avatarImageView.snp.right).offset(8)
            make.top.equalTo(repoTitleLabel.snp.bottom)
            make.width.equalTo(50)
            make.height.equalTo(21)
        }
        authorLabel.snp.makeConstraints { (make) in
            make.left.equalTo(authorNameLabel.snp.right).offset(2)
            make.centerY.equalTo(authorNameLabel)
            make.right.equalTo(-8)
            make.height.equalTo(25)
        }
        forksNumberLabel.snp.makeConstraints { (make) in
            make.left.equalTo(avatarImageView.snp.right).offset(8)
            make.bottom.equalTo(-8)
            make.height.equalTo(21)
            make.width.greaterThanOrEqualTo(10)
        }
        forksLabel.snp.makeConstraints { (make) in
            make.left.equalTo(forksNumberLabel.snp.right).offset(2)
            make.centerY.equalTo(forksNumberLabel)
            make.height.equalTo(21)
            make.width.greaterThanOrEqualTo(10)
        }
        languageNameLabel.snp.makeConstraints { (make) in
            make.right.equalTo(languageLabel.snp.left).offset(-2)
            make.centerY.equalTo(languageLabel)
            make.height.equalTo(languageLabel)
            make.width.greaterThanOrEqualTo(10)
        }
        languageLabel.snp.makeConstraints { (make) in
            make.right.equalTo(-8)
            make.bottom.equalTo(-8)
            make.height.equalTo(21)
            make.width.greaterThanOrEqualTo(10)
        }
    }
}
