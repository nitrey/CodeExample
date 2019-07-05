//
//  CurrencyRatesServiceTests.swift
//  Created by Alexander Antonov on 14/04/2019.
//

import XCTest
@testable import CurrencyRates

class CurrencyRatesServiceTests: XCTestCase {
    
    typealias RatesResult = Result<CurrencyRatesResponse, APIError>
    
    func testResponse_shouldSucceed() {
        
        // Given
        let expected = validResponse
        let validData = encodeToData(expected)
        let mock = NetworkServiceMock(result: .success(validData))
        let service = CurrencyRatesServiceImp(networkService: mock)
        let pairs: [CurrencyPair] = [
            .init(first: .USD, second: .EUR),
            .init(first: .AUD, second: .IDR)
        ]
        var testResult: RatesResult?
        
        // When
        service.obtainRates(for: pairs) { result in
            testResult = result
        }
        
        // Then
        XCTAssertNotNil(testResult)
        XCTAssertEqual(testResult, RatesResult.success(expected))
    }

    func testResponse_shouldBeNetworkError() {
        
        // Given
        let mock = NetworkServiceMock(result: .failure(.unknown))
        let service = CurrencyRatesServiceImp(networkService: mock)
        let pairs: [CurrencyPair] = [
            .init(first: .USD, second: .EUR),
            .init(first: .AUD, second: .IDR)
        ]
        var testResult: RatesResult?
        
        // When
        service.obtainRates(for: pairs) { result in
            testResult = result
        }
        
        // Then
        XCTAssertNotNil(testResult)
        XCTAssertEqual(testResult, RatesResult.failure(.network))
    }
    
    func testResponse_shouldBeInvalidParameters() {
        
        // Given
        let mock = NetworkServiceMock(result: .success(Data()))
        let service = CurrencyRatesServiceImp(networkService: mock)
        let pairs: [CurrencyPair] = [] // INVALID empty input
        var testResult: RatesResult?
        
        // When
        service.obtainRates(for: pairs) { result in
            testResult = result
        }
        
        // Then
        XCTAssertNotNil(testResult)
        XCTAssertEqual(testResult, RatesResult.failure(.invalidParameters))
    }
    
    func testResponse_shouldBeDecodingError() {
        
        // Given
        let invalidData = "invalid".data(using: .utf8)! // INVALID data
        let mock = NetworkServiceMock(result: .success(invalidData))
        let service = CurrencyRatesServiceImp(networkService: mock)
        let pairs: [CurrencyPair] = [
            .init(first: .USD, second: .EUR),
            .init(first: .AUD, second: .IDR)
        ]
        var testResult: RatesResult?
        
        // When
        service.obtainRates(for: pairs) { result in
            testResult = result
        }
        
        // Then
        XCTAssertNotNil(testResult)
        XCTAssertEqual(testResult, RatesResult.failure(.decoding))
    }
    
    // MARK: - Helpers
    var validResponse: CurrencyRatesResponse {
        return CurrencyRatesResponse(rates: [
            CurrencyPair(first: .USD, second: .EUR): 1.1700,
            CurrencyPair(first: .AUD, second: .IDR): 278.9000
        ])
    }
    
    func encodeToData(_ response: CurrencyRatesResponse) -> Data {
        var rates: [String: Decimal] = [:]
        response.rates.forEach { rates[$0.key.rawValue] = $0.value }
        return try! JSONEncoder().encode(rates)
    }

}
