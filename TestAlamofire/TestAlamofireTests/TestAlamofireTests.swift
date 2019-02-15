//
//  TestAlamofireTests.swift
//  TestAlamofireTests
//
//  Created by 1002237 on 05/12/2018.
//  Copyright © 2018 1002237. All rights reserved.
//

import XCTest
import Alamofire

@testable import TestAlamofire

class TestAlamofireTests: XCTestCase {

    private let timeout: TimeInterval = 30.0
    private let serverRoot:String = "http://13.209.75.37:7777"
    private lazy var restApiUrl:String = {
        return "\(serverRoot)\(restApi)"
    }()
    
    private var restApi:String = ""

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    func testServerRoot(){
        // Given
        let urlString = serverRoot
        let expectation = self.expectation(description: "request should succeed")
        
        var response: DefaultDataResponse?
        
        // When
        Alamofire.request(urlString, parameters: nil).response { resp in
            response = resp
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: timeout, handler: nil)
        
        // Then
        XCTAssertNotNil(response?.request)
        XCTAssertNotNil(response?.response)
        XCTAssertNotNil(response?.data)
        XCTAssertNil(response?.error)
        
        if #available(iOS 10.0, macOS 10.12, tvOS 10.0, *) {
            XCTAssertNotNil(response?.metrics)
        }
    }
    
    func testRequestSitterInfo(){
        restApi = "/sitters/ML5CerojX7XZEXxuZXNOxTo3Xc02"
        let expectation = self.expectation(description: "request should succeed")
        
        var response: DefaultDataResponse?
        
        // When
        Alamofire.request(restApiUrl, parameters: nil).response { resp in
            response = resp
            if let data = response?.data{
                
                do{
                    let jsonDecoder = JSONDecoder()
                    let responseModel = try jsonDecoder.decode(DogPlanetJsonModel.self, from: data)
                }catch{
                    
                }
            }
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: timeout, handler: nil)
        
        // Then
        XCTAssertNotNil(response?.request)
        XCTAssertNotNil(response?.response)
        XCTAssertNotNil(response?.data)
        XCTAssertNil(response?.error)
        
        if #available(iOS 10.0, macOS 10.12, tvOS 10.0, *) {
            XCTAssertNotNil(response?.metrics)
        }
    }
}

class TestNetworkAgentTests: XCTestCase {
    
    private let timeout: TimeInterval = 30.0
    
    func testNetworkAgent(){
        
        let expectation = self.expectation(description: "request should succeed")
        var response:DogPlanetJsonModel?
        // When
        NetworkAgent.shared.request(api: "/sitters", method: .get) { (baseModel) in
            response = baseModel
            expectation.fulfill()
        }
        waitForExpectations(timeout: timeout, handler: nil)
        
        // Then
        XCTAssertNotNil(response)
        XCTAssertNotNil(response?.code)
    }
    
    func testSitters(){
        
        let expectation = self.expectation(description: "request should succeed")
        var response:DogPlanetJsonModel?
        // When
        NetworkAgent.shared.request(api: "/sitters", method: .get) { (baseModel) in
            response = baseModel
            expectation.fulfill()
        }
        waitForExpectations(timeout: timeout, handler: nil)
        
        // Then
        XCTAssertNotNil(response)
        XCTAssertNotNil(response?.code)
    }
    
    func testSitterReviews(){
        
        let expectation = self.expectation(description: "request should succeed")
        var response:DogPlanetJsonModel?
        // When
        NetworkAgent.shared.request(api: "/sitters", method: .get) { (baseModel) in
            if let sitterUid = baseModel?.data?.sitters?[0]{
                NetworkAgent.shared.request(api: "/sitters/\(sitterUid)/reviews", method: .get) { (baseModel) in
                    response = baseModel
                    expectation.fulfill()
                }
            }
            
        }
        waitForExpectations(timeout: timeout, handler: nil)
        
        // Then
        XCTAssertNotNil(response)
        XCTAssertNotNil(response?.code)
        XCTAssertEqual(response?.code, "OK")
        
    }
}
