//
//  TableViewDataSourceProtocol.swift
//  GitHub Repositories
//
//  Created by Hasan on 7/25/19.
//  Copyright © 2019 Hasan. All rights reserved.
//

import UIKit

@objc protocol TableViewDataSourceProtocol {
    func numberOfRows(section: Int) -> Int
    
    @objc optional func numberOfSections() -> Int
    @objc optional func heightForRowAt(indexPath: IndexPath) -> CGFloat
    @objc optional func cellForRawAt(indexPath: IndexPath, tableView: UITableView) -> UITableViewCell
}
