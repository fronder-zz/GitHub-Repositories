//
//  GitHub_RepositoriesTests.swift
//  GitHub RepositoriesTests
//
//  Created by Hasan on 7/25/19.
//  Copyright © 2019 Hasan. All rights reserved.
//

import XCTest
import RxSwift
@testable import GitHub_Repositories

class GitHub_RepositoriesTests: XCTestCase {

    let apiService = RepositoryService()
    fileprivate let disposeBag = DisposeBag()
    
    override func setUp() {

    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testRequest() {
        let expectation = self.expectation(description: "Request and parse expectation")
        
        let observable = apiService.requestRepositories(parameters: ["q": "swift"])
        
        observable.subscribe(onNext: { (responseJson) in
            
            do {
                guard let array = responseJson["items"].array else {
                    XCTFail("No items")
                    return
                }
                
                let viewModel = RepositoryListCellViewModel(with: Repository(json: array[0]))
                XCTAssertNotNil(viewModel)
                expectation.fulfill()
            }
            
            
        }, onError: { (error) in
            XCTAssertNil(error)
        }).disposed(by: disposeBag)
        
        wait(for: [expectation], timeout: 5)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}


class RepositoryListViewModelTest: XCTestCase {
    
    var repoSearchListVC: RepositoryListViewController!
    
    override func setUp() {
        super.setUp()
        
    }
    
    override func tearDown() {
        
    }
    
    // Test if data in both side are equal in order to make sure all logic is done within ViewModel
    func testListViewControllerCellData() {
        repoSearchListVC = RepositoryListViewController(with: RepositoryParameter(query: "swift"))
        let _ = repoSearchListVC.view
        
        // Wait for request to complete
        let expectation = self.expectation(description: "RepositoryTableViewCell and RepositoryListCellViewModel data are valid")
        let _ = XCTWaiter.wait(for: [expectation], timeout: 5)
        
        XCTAssertGreaterThan(repoSearchListVC.viewModel.count(), 0)
        
        let indexPath = IndexPath(row: 0, section: 0)
        let cellViewModel = repoSearchListVC.viewModel[0]
        
        let cell = repoSearchListVC.tableView.cellForRow(at: indexPath) as! RepositoryTableViewCell
        
        XCTAssertEqual(cell.repoTitleLabel.text, cellViewModel.name)
        XCTAssertEqual(cell.authorLabel.text, cellViewModel.authorName)
        XCTAssertEqual(cell.forksLabel.text, cellViewModel.forksNumber)
        XCTAssertEqual(cell.languageLabel.text, cellViewModel.language)
        
        expectation.fulfill()
    }
}
