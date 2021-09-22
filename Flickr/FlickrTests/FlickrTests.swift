//
//  FlickrTests.swift
//  FlickrTests
//
//  Created by Carlos Bastida on 21/09/21.
//

import XCTest
@testable import Flickr

class FlickrTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    func testApiResponse() {
        
        let apiClient = API()
        
        let request = "home"
        
        let expectations = self.expectation(description: "Valid JSON Response")
        
        apiClient.getImagesData(with: request) { (result, error) in
            XCTAssertNotNil(result)
            XCTAssertNil(error)
            XCTAssertEqual(result?.title, "Recent Uploads tagged \(request)")
            expectations.fulfill()
        }
                    
        waitForExpectations(timeout: 10, handler: nil)
            
        
    }
    
    func testEmptyApiResponse() {
        
        let apiClient = API()
        
        let request = "cats"
        
        let expectations = self.expectation(description: "Valid JSON Response")
        
        apiClient.getImagesData(with: request) { (result, error) in
            XCTAssertGreaterThan(result?.items?.count as! Int, 0)
            XCTAssertNil(error)
            XCTAssertEqual(result?.title, "Recent Uploads tagged \(request)")
            expectations.fulfill()
        }
                    
        waitForExpectations(timeout: 10, handler: nil)
            
        
    }

}
