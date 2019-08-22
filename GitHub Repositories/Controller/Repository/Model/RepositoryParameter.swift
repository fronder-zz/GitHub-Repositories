//
//  RepositoryParameter.swift
//  GitHub Repositories
//
//  Created by Hasan on 7/25/19.
//  Copyright © 2019 Hasan. All rights reserved.
//

import Foundation
import ObjectMapper

struct RepositoryParameter: Mappable {
    var query: String = ""
    var sort: String = ""
    var order: String = ""
    var page: Int = 1
    var per_page: Int = 10
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        query       <- map["q"]
        sort        <- map["sort"]
        order       <- map["order"]
        page        <- map["page"]
        per_page    <- map["per_page"]
    }
    

    init(query: String, sort: String? = nil, order: String? = nil) {
        self.query = query
        self.sort = sort ?? ""
        self.order = order ?? ""
    }
}
