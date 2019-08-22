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
    @IBOutlet weak var sortTypeDropDown: DropDown!
    @IBOutlet weak var orderDropDown: DropDown!
    
    let sortTypeArray = ["stars", "forks"]
    let orderArray = ["asc", "desc"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        sortTypeDropDown.optionArray = sortTypeArray
        orderDropDown.optionArray = orderArray

    }


}

