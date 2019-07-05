//
//  SelectCurrencyPairCoordinatorTests.swift
//  Created by Alexander Antonov on 10/04/2019.
//

import XCTest
@testable import CurrencyRates

class SelectCurrencyPairCoordinatorTests: XCTestCase {
    
    // MARK: - Properties
    var modelBuilder: ModelBuilderMock!
    var view: ViewMock!
    var router: RouterMock!
    var coordinator: SelectCurrencyPairCoordinator!
    var output: ModuleOutputMock!
    var endedExpectation: XCTestExpectation!
    let asyncTimeout: TimeInterval = 1
    
    // MARK: - Setup
    override func setUp() {
        modelBuilder = ModelBuilderMock()
        coordinator = SelectCurrencyPairCoordinator(modelBuilder: modelBuilder)
        router = RouterMock()
        view = ViewMock(first: .USD, second: .EUR)
        endedExpectation = expectation(description: "Module has finished")
        output = ModuleOutputMock(expectation: endedExpectation)
        
        coordinator.router = router
        coordinator.view = view
        coordinator.moduleOutput = output
        
        view.output = coordinator
        router.view = view
    }
    
    // MARK: - Clean up
    override func tearDown() {
        modelBuilder = nil
        coordinator = nil
        router = nil
        view = nil
        output = nil
        endedExpectation = nil
    }
    
    // MARK: - Tests
    func testModuleOutput_shouldMatchExpectingPair() {
        
        // Given
        let sut = coordinator
        
        // When
        sut?.start()
        
        // Then
        wait(for: [endedExpectation], timeout: asyncTimeout)
        let expected = CurrencyPair(first: .USD, second: .EUR)
        XCTAssertEqual(output.result, expected)
    }
    
    func test_dismissedCalled() {
        
        // Given
        let sut = coordinator
        
        // When
        sut?.start()
        
        // Then
        wait(for: [endedExpectation], timeout: asyncTimeout)
        XCTAssert(router.dismissCalled)
    }
    
    func test_showCurrencyScreenCalled() {
        
        // Given
        let sut = coordinator
        
        // When
        sut?.start()
        
        // Then
        wait(for: [endedExpectation], timeout: asyncTimeout)
        XCTAssert(router.showCurrencyScreenCalled)
    }
    
    func testTimesViewCalled_shouldBeEqualToTwo() {
        
        // Given
        let sut = coordinator
        
        // When
        sut?.start()
        
        // Then
        wait(for: [endedExpectation], timeout: asyncTimeout)
        XCTAssertEqual(view.timesCalled, 2)
    }
    
    func test_buildModelCalled() {
        
        // Given
        let sut = coordinator
        
        // When
        sut?.start()
        
        // Then
        wait(for: [endedExpectation], timeout: asyncTimeout)
        XCTAssert(modelBuilder.buildModelCalled)
    }

}
