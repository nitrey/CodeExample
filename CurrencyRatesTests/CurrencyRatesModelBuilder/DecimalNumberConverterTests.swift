//
//  DecimalNumberConverterTests.swift
//  Created by Alexander Antonov on 14/04/2019.
//

import XCTest
@testable import CurrencyRates

class DecimalNumberConverterTests: XCTestCase {
    
    var sut: DecimalNumberConverterImp!

    override func setUp() {
        sut = DecimalNumberConverterImp()
    }

    override func tearDown() {
        sut = nil
    }

    func testReturnValue_shouldReturnNil() {
        
        // Given
        let input: Decimal? = nil
        
        // When
        let result = sut.valueText(for: input)
        
        // Then
        XCTAssertNil(result)
    }

    func testReturnValue1() {
        
        // Given
        let input: Decimal = 12.93560313
        let expected = ValueText(mainValue: "12.93", centicents: "56")
        
        // When
        let result = sut.valueText(for: input)
        
        // Then
        XCTAssertEqual(result, expected)
    }
    
    func testReturnValue2() {
        
        // Given
        let input: Decimal = 143.0000
        let expected = ValueText(mainValue: "143.00", centicents: "00")
        
        // When
        let result = sut.valueText(for: input)
        
        // Then
        XCTAssertEqual(result, expected)
    }
    
    func testReturnValue3() {
        
        // Given
        let input: Decimal = 0.091
        let expected = ValueText(mainValue: "0.09", centicents: "10")
        
        // When
        let result = sut.valueText(for: input)
        
        // Then
        XCTAssertEqual(result, expected)
    }
    
    func testReturnValue4() {
        
        // Given
        let input: Decimal = 0.00099
        let expected = ValueText(mainValue: "0.00", centicents: "10")
        
        // When
        let result = sut.valueText(for: input)
        
        // Then
        XCTAssertEqual(result, expected)
    }

}
