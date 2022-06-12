//
//  ContactTests.swift
//  ContactTests
//
//  Created by Nikhlesh bagdiya on 10/06/22.
//

import XCTest
@testable import Contact

class ContactTests: XCTestCase {
    
    var contactsManager:ContactsManager? = nil
    
    override func setUp() {
        super.setUp()
        
        contactsManager = ContactsManager.manager
    }
    
    override func tearDown() {
        contactsManager = nil
        super.tearDown()
    }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testGetContacts() {
        let expectation = XCTestExpectation.init(description: "Contacts")
        
        contactsManager?.fetchAllContacts(completionHandler: { contactsObject, error in
            if let contacts = contactsObject {
                XCTAssertGreaterThan(contacts.count, 0)
                
                let contact = contacts[0]
                XCTAssertGreaterThan(contact.fullName.count, 0)
                XCTAssertGreaterThan(contact.number.count, 0)
              
                expectation.fulfill()
           } else if error != nil {
               XCTFail("Fail")
           }
        })

        wait(for: [expectation], timeout: 60)
    }

}
