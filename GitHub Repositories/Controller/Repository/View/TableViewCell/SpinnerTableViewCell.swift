//
//  SpinnerTableViewCell.swift
//  GitHub Repositories
//
//  Created by Hasan on 7/26/19.
//  Copyright © 2019 Hasan. All rights reserved.
//

import UIKit

class SpinnerTableViewCell: BaseTableViewCell {

    lazy var spinner: UIActivityIndicatorView = {
        let layer = UIActivityIndicatorView(style: .gray)
        
        return layer
    }()
    
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setup() {
        contentView.addSubview(spinner)
        
        spinner.snp.makeConstraints { (make) in
            make.centerX.centerY.equalToSuperview()
            make.width.height.equalTo(40)
        }
    }
}
