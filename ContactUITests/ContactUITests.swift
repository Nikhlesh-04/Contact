//
//  ContactUITests.swift
//  ContactUITests
//
//  Created by Nikhlesh bagdiya on 10/06/22.
//

import XCTest

class ContactUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        
        // Since UI tests are more expensive to run, it's usually
        // a good idea to exit if a failure was encountered
        continueAfterFailure = false
        
        app = XCUIApplication()
        
        // We send the uitesting command line argument to the app to
        // reset its state and to use the alert analytics engine
        app.launchArguments.append("--uitesting")
    }
    
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
    
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
    
    func testLogin() {
        
        app.activate()
        app.launch()
        
        if app.buttons["Login"].exists {
            XCTAssertTrue(app.buttons["Login"].exists)
            XCTAssertTrue(app.staticTexts[ConstantsMessages.welcomeText].exists)
        }
    }
    
    func testLoginSucess() {
        
        app.activate()
        app.launch()
        
        if app.buttons["Login"].exists {
            app.buttons["Login"].tap()
            
            // Since this is an asynchronous bound operation, we'll wait for
            sleep(2)
            
            let app2 = XCUIApplication(bundleIdentifier: "com.apple.springboard")
            let button = app2.alerts.firstMatch.buttons["OK"]
            button.tap()
            
            sleep(2)
            
            let table = app.tables[Identifiers.contactTable]
            XCTAssertTrue(table.exists)
            XCTAssertGreaterThan(table.cells.count, 0)
        }
    }
    
    func testLogout() {
        app.activate()
        app.launch()
        
        if app.buttons["Login"].exists {
            app.buttons["Login"].tap()
        }
        
        // Since this is an asynchronous bound operation, we'll wait for
        sleep(2)
        
        XCTAssertTrue(app.buttons["Logout"].exists)
        
        app.buttons["Logout"].tap()
        
        sleep(2)
        
        XCTAssertTrue(app.staticTexts[ConstantsMessages.welcomeText].exists)
    }
    
    func testContactsShow() {
        app.activate()
        app.launch()
        
        if app.buttons["Login"].exists {
            app.buttons["Login"].tap()
        }
        
        // Since this is an asynchronous bound operation, we'll wait for
        sleep(3)
        
        let table = app.tables[Identifiers.contactTable]
        XCTAssertTrue(table.exists)
        XCTAssertGreaterThan(table.cells.count, 0)
        
        let rewardCell = app.tables.firstMatch
        XCTAssertTrue(rewardCell.exists)
    }
}
