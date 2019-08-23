//
//  RepositoryService.swift
//  GitHub Repositories
//
//  Created by Hasan on 7/25/19.
//  Copyright © 2019 Hasan. All rights reserved.
//

import UIKit
import Alamofire
import RxSwift
import SwiftyJSON

class RepositoryService: ApiService {
    
    // Request list of repositories from GitHub service
    func requestRepositories(parameters: ApiService.Parameters?) -> ServiceResponseResult {
        return GET(endpoint: Endpoint.repositories.rawValue, parameters: parameters, headers: nil)
    }
}
