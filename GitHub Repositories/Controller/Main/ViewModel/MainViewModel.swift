//
//  MainViewModel.swift
//  GitHub Repositories
//
//  Created by Hasan on 7/25/19.
//  Copyright © 2019 Hasan. All rights reserved.
//

import Foundation

enum Type: Int {
    case stars = 0
    case forks
    case none
    
    static let titles = [stars: "stars", forks: "forks"]
    
    func title() -> String {
        guard let title = Type.titles[self] else {
            return ""
        }
        
        return title
    }
}

enum SortOrder: Int {
    case desc = 0
    case asc
    
    static let titles = [desc: "desc", asc: "asc"]
    
    func title() -> String {
        guard let title = SortOrder.titles[self] else {
            return ""
        }
        
        return title
    }
}


class MainViewModel {
    
    // MARK: - Variables
    
    fileprivate var type: Type = .none
    fileprivate var order: SortOrder = .desc
    var repoParameter: RepositoryParameter! = nil
    
    let typesArray: [String] = {
        return [Type.titles[.stars]!, Type.titles[.forks]!]
    }()
    
    let ordersArray: [String] = {
        return [SortOrder.titles[.desc]!, SortOrder.titles[.asc]!]
    }()
    
    
    // MARK: - Public
    
    func setType(index: Int) {
        type = Type(rawValue: index) ?? .none
    }
    
    func setOrder(index: Int) {
        order = SortOrder(rawValue: index) ?? .desc
    }
    
    func search(with query: String, block: (Bool, String) -> ()) {
        guard query.count > 0 else {
            block(false, "Please type the text")
            return
        }
        
        repoParameter = RepositoryParameter(query: query, sort: type.title(), order: order.title())
        
        block(true, "")
    }
}
