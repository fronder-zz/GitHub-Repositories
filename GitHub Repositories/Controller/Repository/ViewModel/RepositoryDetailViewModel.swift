//
//  RepositoryDetailViewModel.swift
//  GitHub Repositories
//
//  Created by Hasan on 7/28/19.
//  Copyright © 2019 Hasan. All rights reserved.
//

import UIKit

struct RepositoryDetailViewModel: ListCellPresentable {
    
    var authorName: String?
    var forksNumber: String?
    var language: String?
    var name: String?
    var repo: Repository!
    var description: String {
        if let value = repo.description {
            return value
        } else {
            return "No description"
        }
    }
    var fullName: String {
        if let value = repo.fullName {
            return value
        } else {
            return ""
        }
    }
    var watchers: String {
        return "\(repo.watchers)"
    }
    var htmlUrl: String? {
        return repo.htmlUrl ?? nil
    }
    
    
    init(authorName: String, forksNumber: String, language: String, repoName: String, repo: Repository) {
        self.authorName = authorName
        self.forksNumber = forksNumber
        self.language = language
        self.name = repoName
        self.repo = repo
    }
    
    
}
