//
//  NetworkServiceTests.swift
//  Created by Alexander Antonov on 14/04/2019.
//

import XCTest
@testable import CurrencyRates

class NetworkServiceTests: XCTestCase {
    
    var completedExpectation: XCTestExpectation!
    let asyncTimeout: TimeInterval = 1
    
    override func setUp() {
        completedExpectation = expectation(description: "Completion called")
    }
    
    override func tearDown() {
        completedExpectation = nil
    }
    
    // MARK: - Tests
    func testResult_shouldBeFailureBecauseOfDataAbsence() {
        
        // Given
        let response = makeResponse(code: 200)
        let sessionMock = NetworkSessionMock(data: nil, response: response, error: nil)
        let networkService = NetworkServiceImp(session: sessionMock)
        var testResult: NetworkResult?
        
        // When
        networkService.performRequest(url: sampleUrl) { result in
            testResult = result
            self.completedExpectation.fulfill()
        }
        
        // Then
        wait(for: [completedExpectation], timeout: asyncTimeout)
        XCTAssertNotNil(testResult)
        XCTAssertEqual(testResult, NetworkResult.failure(.unknown))
    }

    func testResult_shouldBeFailureBecauseOfStatusCode() {
        
        // Given
        let response = makeResponse(code: 503)
        let sessionMock = NetworkSessionMock(data: Data(), response: response, error: nil)
        let networkService = NetworkServiceImp(session: sessionMock)
        var testResult: NetworkResult?
        
        // When
        networkService.performRequest(url: sampleUrl) { result in
            testResult = result
            self.completedExpectation.fulfill()
        }
        
        // Then
        wait(for: [completedExpectation], timeout: asyncTimeout)
        XCTAssertNotNil(testResult)
        XCTAssertEqual(testResult, NetworkResult.failure(.unknown))
    }
    
    func testResult_shouldBeFailureBecauseOfError() {
        
        // Given
        let response = makeResponse(code: 200)
        let sessionMock = NetworkSessionMock(data: Data(), response: response, error: NetworkError.unknown)
        let networkService = NetworkServiceImp(session: sessionMock)
        var testResult: NetworkResult?
        
        // When
        networkService.performRequest(url: sampleUrl) { result in
            testResult = result
            self.completedExpectation.fulfill()
        }
        
        // Then
        wait(for: [completedExpectation], timeout: asyncTimeout)
        XCTAssertNotNil(testResult)
        XCTAssertEqual(testResult, NetworkResult.failure(.unknown))
    }
    
    func testResult_shouldBeSuccess() {
        
        // Given
        let response = makeResponse(code: 200)
        let sessionMock = NetworkSessionMock(data: Data(), response: response, error: nil)
        let networkService = NetworkServiceImp(session: sessionMock)
        var testResult: NetworkResult?
        
        // When
        networkService.performRequest(url: sampleUrl) { result in
            testResult = result
            self.completedExpectation.fulfill()
        }
        
        // Then
        wait(for: [completedExpectation], timeout: asyncTimeout)
        XCTAssertNotNil(testResult)
        XCTAssertEqual(testResult, NetworkResult.success(Data()))
    }
    
    // MARK: - Helpers
    var sampleUrl: URL {
        return URL(string: "https://google.com")!
    }
    
    func makeResponse(code: Int) -> HTTPURLResponse {
        return HTTPURLResponse(url: sampleUrl, statusCode: code, httpVersion: nil, headerFields: nil)!
    }

}
