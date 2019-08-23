//
//  UserDetailViewModel.swift
//  GitHub Repositories
//
//  Created by Hasan on 7/27/19.
//  Copyright © 2019 Hasan. All rights reserved.
//

import UIKit

protocol UserDetailsPresentable: NamePresentable {
    var image: UIImage? {get}
}

struct UserDetailViewModel: UserDetailsPresentable {
    
    var image: UIImage?
    var name: String?

    fileprivate var user: User!
    
    var backgroundColor: UIColor {
        get {
            return .white
        }
    }
    
    
    // MARK: - Init
    
    init(with user: User, image: UIImage) {
        self.user = user
        self.name = user.login
        self.image = image
    }
}
