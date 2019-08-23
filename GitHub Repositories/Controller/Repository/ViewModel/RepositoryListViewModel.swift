//
//  RepositoryViewModel.swift
//  GitHub Repositories
//
//  Created by Hasan on 7/25/19.
//  Copyright © 2019 Hasan. All rights reserved.
//

import UIKit
import RxSwift
import Kingfisher

protocol NamePresentable {
    var name: String? {get}
}

protocol AvatarUrlProtocol {
    var avatarUrl: String? {get}
}

protocol ListCellPresentable: NamePresentable {
    var authorName: String? {get}
    var forksNumber: String? {get}
    var language: String? {get}
}

struct RepositoryListCellViewModel: ListCellPresentable, AvatarUrlProtocol {
    var name: String?
    var authorName: String?
    var forksNumber: String?
    var language: String?
    var avatarUrl: String?
    var repo: Repository!
    
    init(with repository: Repository) {
        repo = repository
        name = repo.name ?? "No name"
        authorName = repo.user.login ?? "No name"
        forksNumber = "\(repo.forksCount)"
        language = repo.language ?? "Unknown"
        avatarUrl = repo.user.avatarUrl ?? nil
    }
    
    func setImageTo(imageView: UIImageView) {
        if let urlString = avatarUrl {
            imageView.kf.indicatorType = .activity
            imageView.kf.setImage(
                with: URL(string: urlString),
                placeholder: UIImage(named: "placeholder"),
                options: [
                    .scaleFactor(UIScreen.main.scale),
                    .transition(.fade(1)),
                    .cacheOriginalImage
                ]
                )
            {
                result in
                
                switch result {
                case .success(let value):
                    print("Task done for: \(value.source.url?.absoluteString ?? "")")
                case .failure(let error):
                    print("Job failed: \(error.localizedDescription)")
                }
            }
        }
    }
}

struct Error: ServiceErrorProtocol {
    var message: String?
}

class RepositoryListViewModel: TableViewDataSourceProtocol {
    
    // MARK: - Variables
    
    typealias ResponseCallback = (Bool, ServiceErrorProtocol?) -> ()
    fileprivate let disposeBag = DisposeBag()
    fileprivate var items = [RepositoryListCellViewModel]()
    fileprivate var apiService: RepositoryService!
    fileprivate var isFetchingData = false
    fileprivate let transition = Animator()
    
    var parameterObject: RepositoryParameter!
    var selectedImageCell: RepositoryTableViewCell? = nil
    
    // Listeners
    
    var didStartLoading: () -> () = {}
    var didFinishLoading: () -> () = {}
    
    
    // MARK: - init
    
    init(apiService: RepositoryService) {
        self.apiService = apiService
        
        transition.dismissCompletion = { [weak self] in
            self?.selectedImageCell = nil
        }
    }
    
    
    // MARK: - Public
    
    func fetchData(completion: @escaping ResponseCallback) {
        requestData(completion: completion)
    }
    
    func fetchMore() {
        isFetchingData = true
        didStartLoading()
        parameterObject.page += 1
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            self.requestData() { [weak self] (success, error) in
                self?.didFinishLoading()
                self?.isFetchingData = false
            }
        })
    }
    
    subscript(indexPath: IndexPath) -> RepositoryListCellViewModel {
        return items[indexPath.row]
    }
    
    subscript(row: Int) -> RepositoryListCellViewModel {
        return items[row]
    }
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY > contentHeight - scrollView.frame.height * 4 {
            if !isFetchingData {
                fetchMore()
            }
        }
    }
    
    func transition(tableView: UITableView, convertView view: UIView) -> Animator? {
        guard let selectedCellSuperview = selectedImageCell?.superview else {return nil}
        
        transition.originFrame = selectedCellSuperview.convert(selectedImageCell!.frame, to: nil)
        transition.originFrame = CGRect(
            x: transition.originFrame.origin.x + 20,
            y: transition.originFrame.origin.y + 20,
            width: transition.originFrame.size.width - 40,
            height: transition.originFrame.size.height - 40
        )
        
        transition.presenting = true
        
        return transition
    }
    
    func transition(presenting: Bool) -> Animator {
        transition.presenting = presenting
        return transition
    }
    
    
    // MARK: - Private
    
    private func requestData(completion: @escaping ResponseCallback) {
        let observable = apiService.requestRepositories(parameters: parameterObject.toJSON())
        
        observable.subscribe(onNext: { [weak self] (responseJson) in
            guard let array = responseJson["items"].array else {
                completion(false, nil)
                return
            }
            
            guard let _self = self else {
                completion(false, nil)
                return
            }
            
            let newItems = array.map { RepositoryListCellViewModel(with: Repository(json: $0)) }
            _self.items.append(contentsOf: newItems)
            
            print("items count: \(String(describing: self?.items.count))")
            
            completion(true, nil)
            
            }, onError: { (error) in
                
                let value = Error(message: "Something went wrong")
                completion(false, value)
                
        }).disposed(by: disposeBag)
    }
    
    func count() -> Int {
        return numberOfRows(section: 0)
    }
    
    
    // MARK: - TableViewDataSourceProtocol
    
    func numberOfSections() -> Int {
        return 2
    }
    
    func heightForRowAt(indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func numberOfRows(section: Int) -> Int {
        switch section {
        case 0:
            return items.count
        case 1:
            guard isFetchingData else {return 0}
            
            return 1
        default:
            return 0
        }
    }
    
    func cellForRawAt(indexPath: IndexPath, tableView: UITableView) -> UITableViewCell {
        guard indexPath.section == 0 else {
            let cell = tableView.dequeueReusableCell(withIdentifier: SpinnerTableViewCell.cellIdentifier, for: indexPath) as! SpinnerTableViewCell
            cell.spinner.startAnimating()
            
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: RepositoryTableViewCell.cellIdentifier, for: indexPath) as! RepositoryTableViewCell
        cell.setViewModel(with: self[indexPath])
        cell.selectionStyle = .none
        
        return cell
    }
    
}
