//
//  RepositoryListViewController.swift
//  GitHub Repositories
//
//  Created by Hasan on 7/25/19.
//  Copyright © 2019 Hasan. All rights reserved.
//

import UIKit

class RepositoryListViewController: BaseViewController, RepositoryTableViewCellDelegate, UIViewControllerTransitioningDelegate {
    
    // MARK: - Variables
    
    var viewModel: RepositoryListViewModel!
    private(set) var parameter: RepositoryParameter? {
        didSet {
            viewModel.parameterObject = self.parameter
        }
    }
    
    
    // MARK: - Lifecycle
    
    convenience init(with parameter: RepositoryParameter) {
        self.init()
        
        defer {
            setupViewModel()
            self.parameter = parameter
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Dismiss", style: .done, target: self, action: #selector(dismissController))
        
        setupTableView()
        fetch()
    }
    
    
    // MARK: - Public
    
    override func setupTableView() {
        super.setupTableView()
        
        tableView.register(RepositoryTableViewCell.self, forCellReuseIdentifier: RepositoryTableViewCell.cellIdentifier)
        tableView.register(SpinnerTableViewCell.self, forCellReuseIdentifier: SpinnerTableViewCell.cellIdentifier)
    }
    
    
    // MARK: - Private
    
    private func setupViewModel() {
        viewModel = RepositoryListViewModel(apiService: RepositoryService())
        
        // viewModel listeners
        viewModel.didStartLoading = { [weak self] in
            self?.tableView.reloadSections(IndexSet(integer: 1), with: .none)
        }
        
        viewModel.didFinishLoading = { [weak self] in
            self?.tableView.reloadData()
        }
    }
   
    private func fetch() {
        showLoader()
        viewModel.fetchData { [weak self] (success, error) in
            self?.hideLoader()
            if success {
                self?.tableView.reloadData()
            } else {
                self?.showAlertWarning(error!.message!)
            }
        }
    }
    
    
    // MARK: - UITableViewDataSiurce/UITableViewDelegate
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.heightForRowAt(indexPath: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(section: section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard indexPath.section == 0 else {
            return viewModel.cellForRawAt(indexPath: indexPath, tableView: tableView) as! SpinnerTableViewCell
        }
        
        let cell = viewModel.cellForRawAt(indexPath: indexPath, tableView: tableView) as! RepositoryTableViewCell
        cell.delegate = self
            
        return cell
    }
    
    
    // MARK: - UIScrollViewDelegate
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        viewModel.scrollViewWillBeginDecelerating(scrollView)
    }
    
    
    // MARK: - RepositoryTableViewCellDelegate
    
    func avatarImageViewDidSelect(with userDetailViewModel: UserDetailViewModel, cell: RepositoryTableViewCell) {
        viewModel.selectedImageCell = cell
        
        let vc = UserDetailsViewController(with: userDetailViewModel)
        vc.transitioningDelegate = self
        
        present(vc, animated: true, completion: nil)
    }
    
    func cellDidClick(with repoDetailsViewModel: RepositoryDetailViewModel) {
        let vc = RepositoryDetailsViewController.instantiate()
        vc.viewModel = repoDetailsViewModel
        navigationController?.pushViewController(vc, animated: true)
    }

    
    // MARK: - UIViewControllerTransitioningDelegate
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return viewModel.transition(tableView: tableView, convertView: view)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return viewModel.transition(presenting: false)
    }
}
