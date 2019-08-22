//
//  RepositoryViewModel.swift
//  GitHub Repositories
//
//  Created by Hasan on 7/25/19.
//  Copyright © 2019 Hasan. All rights reserved.
//

import UIKit
import RxSwift

protocol NamePresentable {
    var name: String? {get}
}

protocol ListCellPresentable: NamePresentable {
    var authorName: String? {get}
    var forksNumber: String? {get}
    var language: String? {get}
    var avatarUrl: String? {get}
}

struct RepositoryListCellViewModel: ListCellPresentable {
    var name: String?
    var authorName: String?
    var forksNumber: String?
    var language: String?
    var avatarUrl: String?
    var repo: Repository!
    
    init(repository: Repository) {
        repo = repository
        name = repo.name ?? "No name"
        authorName = repo.user.login ?? "No name"
        forksNumber = "\(repo.forksCount)"
        language = repo.language ?? "Unknown"
        avatarUrl = repo.user.avatarUrl ?? nil
    }
}

struct Error: ServiceError {
    var message: String?
}

class RepositoryListViewModel: TableViewDataSourceProtocol {
    
    // MARK: - Variables
    
    typealias ResponseCallback = (Bool, ServiceError?) -> ()
    fileprivate let disposeBag = DisposeBag()
    fileprivate var items = [RepositoryListCellViewModel]()
    fileprivate var apiService: RepositoryService!
    var parameterObject: RepositoryParameter!
    
    
    // MARK: - init
    
    init(apiService: RepositoryService) {
        self.apiService = apiService
    }
    
    
    // MARK: - Public
    
    func fetchData(completion: @escaping ResponseCallback) {
        let observable = apiService.requestRepositories(parameters: parameterObject.toJSON())
        
        observable.subscribe(onNext: { [weak self] (responseJson) in
            if let array = responseJson["items"].array {
                for i in array {
                    let object = RepositoryListCellViewModel(repository: Repository(json: i))
                    self?.items.append(object)
                }
            }
            
            completion(true, nil)
        }, onError: { (error) in
            let value = Error(message: "Something went wrong")
            completion(true, value)
        }).disposed(by: disposeBag)
    }
    
    subscript(indexPath: IndexPath) -> RepositoryListCellViewModel {
        return items[indexPath.row]
    }
    
    
    // MARK: - TableViewDataSourceProtocol
    
    func heightForRowAt(indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func numberOfRows(section: Int) -> Int {
        return items.count
    }
    
    func didSelectRowAt(_ indexPath: IndexPath) {
        
    }
}
