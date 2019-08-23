//
//  BaseViewController.swift
//  GitHub Repositories
//
//  Created by Hasan on 7/25/19.
//  Copyright © 2019 Hasan. All rights reserved.
//

import UIKit
import SnapKit

class BaseViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: Variables
    
    lazy var tableView: UITableView = {
        let layer = UITableView()
        layer.dataSource = self
        layer.delegate = self
        
        return layer
    }()
    
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    // MARK: - Public
    
    func setupTableView() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints({ (make) in
            make.edges.equalToSuperview()
        })
    }
    
    @objc func dismissController() {
        dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: - Instantiate
    
    class func instantiate() -> UIViewController {
        return UIViewController()
    }
    
    static func instantiate(viewControllerIdentifier: String) -> UIViewController {
        return instantiate(storyboardName: "Main", viewControllerIdentifier: viewControllerIdentifier)!
    }
    
    static func instantiate(storyboardName: String, viewControllerIdentifier: String) -> UIViewController? {
        return UIStoryboard(name: storyboardName, bundle: nil).instantiateViewController(withIdentifier: viewControllerIdentifier)
    }
    
    
    // MARK: - UITableViewDataSiurce
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier", for: indexPath)
        return cell
    }
}
