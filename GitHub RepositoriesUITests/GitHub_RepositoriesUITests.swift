//
//  GitHub_RepositoriesUITests.swift
//  GitHub RepositoriesUITests
//
//  Created by Hasan on 7/25/19.
//  Copyright © 2019 Hasan. All rights reserved.
//

import XCTest
import Alamofire

class GitHub_RepositoriesUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testMainViewControllerSearchBegins() {
        let app = XCUIApplication()
        
        let sortByElementsQuery = XCUIApplication().otherElements.containing(.staticText, identifier:"Sort by:")

        let sortByForksStarsLabel = sortByElementsQuery.children(matching: .staticText).matching(identifier: "Sort by:").element(boundBy: 0)
        XCTAssertTrue(sortByForksStarsLabel.exists)

        let sortByOrderLabel = sortByElementsQuery.children(matching: .staticText).matching(identifier: "Sort by:").element(boundBy: 1)
        XCTAssertTrue(sortByOrderLabel.exists)

        let searchField = app.textFields["Search repository from GitHub"]
        XCTAssertTrue(searchField.exists)

        let searchButton = app.buttons["Search"]
        XCTAssertTrue(searchButton.exists)
    }
    
    func testMainViewControllerSearchFailed()  {
        
        let app = XCUIApplication()
        let textField = app.textFields["Search repository from GitHub"]
        XCTAssertTrue(textField.title.count == 0)
        
        app.buttons["Search"].tap()
        
        let expectation1 = self.expectation(description: "Alert dialog show")
        let _ = XCTWaiter.wait(for: [expectation1], timeout: 0.5)
        
        let alertDialog = app.otherElements["SCLAlertView"].children(matching: .other).element.children(matching: .other).element.children(matching: .textView).element
        XCTAssertTrue(alertDialog.exists)
        
        app/*@START_MENU_TOKEN@*/.buttons["OK"]/*[[".otherElements[\"SCLAlertView\"].buttons[\"OK\"]",".buttons[\"OK\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()

        let expectation2 = self.expectation(description: "Alert dialog hide")
        let _ = XCTWaiter.wait(for: [expectation2], timeout: 0.5)

        XCTAssertFalse(alertDialog.exists)
    }
    
}
