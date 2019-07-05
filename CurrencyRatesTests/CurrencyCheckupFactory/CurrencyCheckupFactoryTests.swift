//
//  CurrencyCheckupFactoryTests.swift
//  Created by Alexander Antonov on 10/04/2019.
//

import XCTest
@testable import CurrencyRates

class CurrencyCheckupFactoryTests: XCTestCase {
    
    // MARK: - Any possible pair exist
    func testCheckAnyAvailablePairExist_checkupShouldPassForEveryCurrency() {
        
        // Given
        let currencies: [Currency] = [.USD, .EUR, .NOK, .CZK]
        let inputPairs: [(Currency, Currency)] = [(.USD, .EUR), (.USD, .CZK)]
        let pairsArray = inputPairs.compactMap { CurrencyPair(first: $0.0, second: $0.1) }
        let existingPairs = Set<CurrencyPair>(pairsArray)
        let factory = CurrencyCheckupFactoryImp(currencies: currencies, existingPairs: existingPairs)
        
        // When
        let checkup = factory.makeCheckup(for: .anyPossiblePairExist)
        let availability = currencies.map { checkup($0) }
        
        // Then
        XCTAssertEqual(availability, [true, true, true, true])
    }
    
    func testCheckAnyAvailablePairExist_checkupShouldPassForEveryCurrencyExceptUSD() {
        
        // Given
        let currencies: [Currency] = [.USD, .EUR, .NOK, .CZK]
        let inputPairs: [(Currency, Currency)] = [(.USD, .EUR), (.USD, .NOK), (.USD, .CZK)]
        let pairsArray = inputPairs.compactMap { CurrencyPair(first: $0.0, second: $0.1) }
        let existingPairs = Set<CurrencyPair>(pairsArray)
        let factory = CurrencyCheckupFactoryImp(currencies: currencies, existingPairs: existingPairs)
        
        // When
        let checkup = factory.makeCheckup(for: .anyPossiblePairExist)
        let result = currencies.map { checkup($0) }
        
        // Then
        XCTAssertEqual(result, [false, true, true, true])
    }
    
    // MARK: - Currencies don't match
    func testcurrenciesDontMatch_checkupShouldPass() {
        
        // Given
        let first: Currency = .USD
        let second: Currency = .EUR
        let factory = CurrencyCheckupFactoryImp(currencies: [], existingPairs: [])
        
        // When
        let checkup = factory.makeCheckup(for: .currenciesDontMatch(other: second))
        let result = checkup(first)
        
        // Then
        XCTAssert(result)
    }
    
    func testcurrenciesDontMatch_checkupShouldFail() {
        
        // Given
        let first: Currency = .USD
        let second = first // Currencies match
        let factory = CurrencyCheckupFactoryImp(currencies: [], existingPairs: [])
        
        // When
        let checkup = factory.makeCheckup(for: .currenciesDontMatch(other: second))
        let result = checkup(first)
        
        // Then
        XCTAssertFalse(result)
    }
    
    // MARK: - Pair doesn't exist
    func testPairDoesntExist_checkupShouldPass() {
        
        // Given
        let first: Currency = .USD
        let second: Currency = .NOK
        let inputPairs: [(Currency, Currency)] = [(.USD, .EUR), (.USD, .CZK)]
        let pairsArray = inputPairs.compactMap { CurrencyPair(first: $0.0, second: $0.1) }
        let existingPairs = Set<CurrencyPair>(pairsArray)
        let factory = CurrencyCheckupFactoryImp(currencies: [], existingPairs: existingPairs)
        
        // When
        let checkup = factory.makeCheckup(for: .pairDoesntExist(first: first))
        let result = checkup(second)
        
        // Then
        XCTAssert(result)
    }
    
    // MARK: - Pair doesn't exist
    func testPairDoesntExist_checkupShouldFail() {
        
        // Given
        let first: Currency = .USD
        let second: Currency = .EUR
        let inputPairs: [(Currency, Currency)] = [(.USD, .EUR), (.USD, .CZK)]
        let pairsArray = inputPairs.compactMap { CurrencyPair(first: $0.0, second: $0.1) }
        let existingPairs = Set<CurrencyPair>(pairsArray)
        let factory = CurrencyCheckupFactoryImp(currencies: [], existingPairs: existingPairs)
        
        // When
        let checkup = factory.makeCheckup(for: .pairDoesntExist(first: first))
        let result = checkup(second)
        
        // Then
        XCTAssertFalse(result)
    }
    
    // MARK: - Reduce checkups
    func testReduceCheckups_reducesCheckupShouldPass() {
        
        // Given
        let testCurrency: Currency = .USD
        let otherCurrency: Currency = .AUD
        let currencies: [Currency] = [.USD, .AUD, .INR, .NOK]
        let inputPairs: [(Currency, Currency)] = [(.USD, .AUD), (.USD, .INR), (.AUD, .NOK)]
        let pairsArray = inputPairs.compactMap { CurrencyPair(first: $0.0, second: $0.1) }
        let existingPairs = Set<CurrencyPair>(pairsArray)
        let factory = CurrencyCheckupFactoryImp(currencies: currencies, existingPairs: existingPairs)
        
        // When
        let checkups: [CurrencyCheckup] = [
            factory.makeCheckup(for: .anyPossiblePairExist),
            factory.makeCheckup(for: .currenciesDontMatch(other: otherCurrency)),
            factory.makeCheckup(for: .pairDoesntExist(first: otherCurrency))
        ]
        let overallCheckup = factory.reduce(checkups)
        let result = overallCheckup(testCurrency)
        
        // Then
        XCTAssert(result)
    }
    
    func testReduceCheckups_reducesCheckupShouldFail1() {
        
        // Given
        let testCurrency: Currency = .USD
        let otherCurrency: Currency = .AUD
        let currencies: [Currency] = [.USD, .AUD, .INR, .NOK]
        let inputPairs: [(Currency, Currency)] = [(.USD, .AUD), (.USD, .INR), (.USD, .NOK)] // All possible pairs exist
        let pairsArray = inputPairs.compactMap { CurrencyPair(first: $0.0, second: $0.1) }
        let existingPairs = Set<CurrencyPair>(pairsArray)
        let factory = CurrencyCheckupFactoryImp(currencies: currencies, existingPairs: existingPairs)
        
        // When
        let checkups: [CurrencyCheckup] = [
            factory.makeCheckup(for: .anyPossiblePairExist), // Should fail
            factory.makeCheckup(for: .currenciesDontMatch(other: otherCurrency)),
            factory.makeCheckup(for: .pairDoesntExist(first: otherCurrency))
        ]
        let overallCheckup = factory.reduce(checkups)
        let result = overallCheckup(testCurrency)
        
        // Then
        XCTAssertFalse(result)
    }
    
    func testReduceCheckups_reducesCheckupShouldFail2() {
        
        // Given
        let testCurrency: Currency = .USD
        let otherCurrency = testCurrency // Currencies match
        let currencies: [Currency] = [.USD, .AUD, .INR, .NOK]
        let inputPairs: [(Currency, Currency)] = [(.USD, .AUD), (.USD, .INR), (.AUD, .NOK)]
        let pairsArray = inputPairs.compactMap { CurrencyPair(first: $0.0, second: $0.1) }
        let existingPairs = Set<CurrencyPair>(pairsArray)
        let factory = CurrencyCheckupFactoryImp(currencies: currencies, existingPairs: existingPairs)
        
        // When
        let checkups: [CurrencyCheckup] = [
            factory.makeCheckup(for: .anyPossiblePairExist),
            factory.makeCheckup(for: .currenciesDontMatch(other: otherCurrency)), // Should fail
            factory.makeCheckup(for: .pairDoesntExist(first: otherCurrency))
        ]
        let overallCheckup = factory.reduce(checkups)
        let result = overallCheckup(testCurrency)
        
        // Then
        XCTAssertFalse(result)
    }
    
    func testReduceCheckups_reducesCheckupShouldFail3() {
        
        // Given
        let testCurrency: Currency = .USD
        let otherCurrency: Currency = .AUD
        let currencies: [Currency] = [.USD, .AUD, .INR, .NOK]
        let inputPairs: [(Currency, Currency)] = [(.AUD, .USD), (.NOK, .INR), (.AUD, .NOK)] // Pair already exists
        let pairsArray = inputPairs.compactMap { CurrencyPair(first: $0.0, second: $0.1) }
        let existingPairs = Set<CurrencyPair>(pairsArray)
        let factory = CurrencyCheckupFactoryImp(currencies: currencies, existingPairs: existingPairs)
        
        // When
        let checkups: [CurrencyCheckup] = [
            factory.makeCheckup(for: .anyPossiblePairExist),
            factory.makeCheckup(for: .currenciesDontMatch(other: otherCurrency)),
            factory.makeCheckup(for: .pairDoesntExist(first: otherCurrency)) // Should fail
        ]
        let overallCheckup = factory.reduce(checkups)
        let result = overallCheckup(testCurrency)
        
        // Then
        XCTAssertFalse(result)
    }

}
