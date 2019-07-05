//
//  CurrencyRatesModelBuilderTests.swift
//  Created by Alexander Antonov on 14/04/2019.
//

import XCTest
@testable import CurrencyRates

class CurrencyRatesModelBuilderTests: XCTestCase {
    
    typealias ViewModel = CurrencyRatesViewModel
    typealias Section = CurrencyRatesViewModel.Section
    typealias Item = ConversionRateItem
    
    var sut: CurrencyRatesViewModelBuilder!

    override func setUp() {
        sut = CurrencyRatesViewModelBuilderImp()
    }

    override func tearDown() {
        sut = nil
    }
    
    // MARK: - Test build model
    func testBuildModel_shouldReturnEmptyModel() {
        
        // Given
        let items: [Item] = []
        
        // When
        let viewModel = sut.viewModel(with: items)
        
        // Then
        XCTAssertTrue(viewModel.isEmpty)
        XCTAssertEqual(viewModel.items.count, items.count)
    }
    
    func testBuildModel_shouldReturnValidModel1() {
        
        // Given
        let items: [Item] = [Item(pair: CurrencyPair(first: .USD, second: .EUR), value: 0.87)]
        
        // When
        let viewModel = sut.viewModel(with: items)
        
        // Then
        XCTAssertFalse(viewModel.isEmpty)
        XCTAssertEqual(viewModel.items.count, items.count)
        items.enumerated().forEach { (index, item) in
            XCTAssertEqual(viewModel.items[index].pair, item.pair)
        }
    }
    
    func testBuildModel_shouldReturnValidModel2() {
        
        // Given
        let items: [Item] = [
            Item(pair: CurrencyPair(first: .RUB, second: .INR), value: 223.7040),
            Item(pair: CurrencyPair(first: .CZK, second: .NOK), value: 0.2340),
            Item(pair: CurrencyPair(first: .USD, second: .EUR), value: 0.87)
        ]
        
        // When
        let viewModel = sut.viewModel(with: items)
        
        // Then
        XCTAssertFalse(viewModel.isEmpty)
        XCTAssertEqual(viewModel.items.count, items.count)
        items.enumerated().forEach { (index, item) in
            XCTAssertEqual(viewModel.items[index].pair, item.pair)
        }
    }
    
    // MARK: - Test inserting currency pair
    func testBuildModelInsertingNewPair_shouldReturnValidUpdatedModel() {
        
        // Given
        var items: [Item] = [
            Item(pair: CurrencyPair(first: .RUB, second: .INR), value: 223.7040),
            Item(pair: CurrencyPair(first: .CZK, second: .NOK), value: 0.2340),
            Item(pair: CurrencyPair(first: .USD, second: .EUR), value: 0.87)
        ]
        let initialModel = sut.viewModel(with: items) // valid if tests above pass
        let pairToInsert = CurrencyPair(first: .USD, second: .EUR)
        
        // When
        let (resultModel, _) = sut.updateModelInserting(in: initialModel, newPair: pairToInsert)
        items.insert(Item(pair: pairToInsert, value: nil), at: 0)
        
        // Then
        XCTAssertFalse(resultModel.isEmpty)
        items.enumerated().forEach { (index, item) in
            XCTAssertEqual(resultModel.items[index].pair, item.pair)
        }
    }
    
    func testBuildModelInsertingNewPair_shouldNonEmptyModelWithInsertedItem() {
        
        // Given
        var items: [Item] = []
        let initialModel = sut.viewModel(with: items) // valid if tests above pass
        let pairToInsert = CurrencyPair(first: .USD, second: .EUR)
        
        // When
        let (resultModel, _) = sut.updateModelInserting(in: initialModel, newPair: pairToInsert)
        items.insert(Item(pair: pairToInsert, value: nil), at: 0)
        
        // Then
        XCTAssertFalse(resultModel.isEmpty)
        items.enumerated().forEach { (index, item) in
            XCTAssertEqual(resultModel.items[index].pair, item.pair)
        }
    }
    
    // MARK: - Test deleting currency pair
    func testBuildModelDeletingPair_shouldReturnEmptyModel() {
        
        // Given
        var items: [Item] = [Item(pair: CurrencyPair(first: .USD, second: .EUR), value: 0.87)]
        let initialModel = sut.viewModel(with: items) // valid if tests above pass
        
        // When
        let (resultModel, _) = sut.updateModelDeleting(in: initialModel, at: IndexPath(item: 0, section: 1))
        items.remove(at: 0)
        
        // Then
        XCTAssertTrue(resultModel.isEmpty)
        XCTAssertTrue(resultModel.items.count == 0)
    }
    
    func testBuildModelDeletingPair_shouldReturnModelWithValidItems() {
        
        // Given
        var items: [Item] = [
            Item(pair: CurrencyPair(first: .RUB, second: .INR), value: 223.7040),
            Item(pair: CurrencyPair(first: .CZK, second: .NOK), value: 0.2340),
            Item(pair: CurrencyPair(first: .USD, second: .EUR), value: 0.87)
        ]
        let initialModel = sut.viewModel(with: items) // valid if tests above pass
        let indexToDelete = 1
        
        // When
        let (resultModel, _) = sut.updateModelDeleting(in: initialModel, at: IndexPath(item: indexToDelete, section: 1))
        items.remove(at: indexToDelete)
        
        // Then
        XCTAssertFalse(resultModel.isEmpty)
        items.enumerated().forEach { (index, item) in
            XCTAssertEqual(resultModel.items[index].pair, item.pair)
        }
    }

}
