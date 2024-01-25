//
//  SearchFMWiproUITests.swift
//  SearchFMWiproUITests
//
//  Created by AG on 22/01/24.
//  Copyright © 2024 AG. All rights reserved.
//

import XCTest

@testable import SearchFMWipro

final class SearchFMWiproUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testViewControllerInitialization() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        let searchBarElement = app.otherElements["searchBar"]
        XCTAssertTrue(searchBarElement.exists)
        
                let tableView = app.tables["tableView"]
        XCTAssertTrue(tableView.exists)
    }
    
    func testUISearchBarTyping() throws {

        let app = XCUIApplication()
        app.launch()
        
         let searchBarElement = app.otherElements["searchBar"]
         XCTAssertTrue(searchBarElement.exists)
         
         searchBarElement.tap()
         XCTAssertTrue(app.keyboards.firstMatch.exists)
         
         searchBarElement.typeText("justin")
         
     }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
