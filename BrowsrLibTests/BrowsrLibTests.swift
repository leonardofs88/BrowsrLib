//
//  BrowsrLibTests.swift
//  BrowsrLibTests
//
//  Created by Leonardo Soares on 15/02/23.
//

import XCTest
@testable import BrowsrLib

final class BrowsrLibTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testLoadedPages() {
        let expectations = expectation(description: "testLoadedPages")
        let repository = MockLoaderRepository()
        repository.loadData(pageIndex: nil) { result in
            switch result {
            case .success(let items):
                XCTAssertEqual(items.count, 30)
                expectations.fulfill()
            case .failure(let error):
                XCTFail("Shouldn't falil: \(error.localizedDescription)")
                expectations.fulfill()
            }
        }
        
        waitForExpectations(timeout: 5)
    }
    
    func testLoadedIndividualOrganization() {
        let expectations = expectation(description: "testLoadedIndividualOrganization")
        let repository = MockLoaderRepository()
        repository.searchOrganization(searchTerm: nil) { result in
            switch result {
            case .success(let organization):
                XCTAssertNotNil(organization.first)
                XCTAssertEqual(organization.first?.login, "github")
                expectations.fulfill()
            case .failure(let error):
                XCTFail("Shouldn't falil: \(error.localizedDescription)")
                expectations.fulfill()
            }
        }
        
        waitForExpectations(timeout: 5)
    }
    
}
