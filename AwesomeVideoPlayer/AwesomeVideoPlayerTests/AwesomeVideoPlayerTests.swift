//
//  AwesomeVideoPlayerTests.swift
//  AwesomeVideoPlayerTests
//
//  Created by Sonny on 2018/08/01.
//  Copyright © 2018 Sonny. All rights reserved.
//

import XCTest
@testable import AwesomeVideoPlayer

class AwesomeVideoPlayerTests: XCTestCase {
    
    var apiManager: APIManager!
    var sessionTest: URLSession!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        apiManager = APIManager()
        sessionTest = URLSession(configuration: .default)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testEndPoint200() {
        let url = URL(string: "https://quipper.github.io/native-technical-exam/playlist.json")
        let promise = expectation(description: "Completion handler invoked")
        var statusCode: Int?
        var responseError: Error?
        guard let dataURL = url else {
            XCTFail("The url is incorrect! \(String(describing: url))")
            return
        }
        sessionTest.dataTask(with: dataURL) { (_, response, error) in
            statusCode = (response as? HTTPURLResponse)?.statusCode
            responseError = error
            promise.fulfill()
        }.resume()
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssertNil(responseError)
        XCTAssertEqual(statusCode, 200)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
