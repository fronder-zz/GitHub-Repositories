//
//  MainViewController.swift
//  GitHub Repositories
//
//  Created by Hasan on 7/25/19.
//  Copyright © 2019 Hasan. All rights reserved.
//

import UIKit
import iOSDropDown

class MainViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var sortTypeDropDown: DropDown!
    @IBOutlet weak var orderDropDown: DropDown!
    @IBOutlet weak var queryTextField: UITextField!
    
    // MARK: - Variables
    
    private let viewModel = MainViewModel()
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupDropDown()
    }
    
    
    // MARK: - Action
    
    @IBAction func searchButtonDidClick(_ sender: Any) {
        viewModel.search(with: queryTextField.text ?? "") { (success, message) in
            if success {
                let vc = RepositoryListViewController(with: viewModel.repoParameter)
                self.present(UINavigationController(rootViewController: vc), animated: true, completion: nil)
            } else {
                showAlert("Warning", message, type: .error)
            }
        }
    }
    
    
    
    // MARK: - Private
    // Setup dropdown menu to choose sorting
    private func setupDropDown() {
        sortTypeDropDown.optionArray = viewModel.typesArray
        orderDropDown.optionArray = viewModel.ordersArray
        
        sortTypeDropDown.didSelect{ [weak self] (selectedText , index ,id) in
            self?.viewModel.setType(index: index)
        }
        
        orderDropDown.didSelect{ [weak self] (selectedText , index ,id) in
            self?.viewModel.setOrder(index: index)
        }
    }
}

