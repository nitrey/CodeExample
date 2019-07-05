//
//  CurrencyPairTests.swift
//  Created by Alexander Antonov on 10/04/2019.
//

import XCTest
@testable import CurrencyRates

class CurrencyPairTests: XCTestCase {
    
    func testInit_shouldReturnValidEntity1() {
        
        // Given
        let input: (Currency, Currency) = (.USD, .EUR)
        let rawValue = input.0.rawValue + input.1.rawValue
        
        // When
        let pair = CurrencyPair(rawValue: rawValue)
        
        // Then
        let expected = CurrencyPair(first: input.0, second: input.1)
        XCTAssertEqual(pair, expected)
    }
    
    func testInit_shouldReturnValidEntity2() {
        
        // Given
        let input: (Currency, Currency) = (.AUD, .INR)
        let rawValue = input.0.rawValue + input.1.rawValue
        
        // When
        let pair = CurrencyPair(rawValue: rawValue)
        
        // Then
        let expected = CurrencyPair(first: input.0, second: input.1)
        XCTAssertEqual(pair, expected)
    }
    
    func testInit_shouldReturnValidEntity3() {
        
        // Given
        let input: (Currency, Currency) = (.CZK, .NOK)
        let rawValue = input.0.rawValue + input.1.rawValue
        
        // When
        let pair = CurrencyPair(rawValue: rawValue)
        
        // Then
        let expected = CurrencyPair(first: input.0, second: input.1)
        XCTAssertEqual(pair, expected)
    }
    
    func testInit_invalidRawValue_shouldReturnNil1() {
        
        // Given
        let input: (Currency, Currency) = (.USD, .EUR)
        let rawValue = input.0.rawValue + "A" + input.1.rawValue
        
        // When
        let pair = CurrencyPair(rawValue: rawValue)
        
        // Then
        XCTAssertNil(pair)
    }
    
    func testInit_invalidRawValue_shouldReturnNil2() {
        
        // Given
        let input: (Currency, Currency) = (.AUD, .INR)
        var rawValue = input.0.rawValue + input.1.rawValue
        rawValue = rawValue.dropFirst().toString
        
        // When
        let pair = CurrencyPair(rawValue: rawValue)
        
        // Then
        XCTAssertNil(pair)
    }
    
    func testInit_invalidRawValue_shouldReturnNil3() {
        
        // Given
        let input: (Currency, Currency) = (.CZK, .NOK)
        var rawValue = input.0.rawValue + input.1.rawValue
        rawValue = rawValue.dropFirst().toString
        
        // When
        let pair = CurrencyPair(rawValue: rawValue)
        
        // Then
        XCTAssertNil(pair)
    }
    
    func testInit_invalidRawValue_shouldReturnNil4() {
        
        // Given
        let input: (Currency, Currency) = (.NOK, .NOK) // Currencies match
        let rawValue = input.0.rawValue + input.1.rawValue
        
        // When
        let pair = CurrencyPair(rawValue: rawValue)
        
        // Then
        XCTAssertNil(pair)
    }
    
}
