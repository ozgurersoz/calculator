//
//  CalculatorFeatureTests.swift
//  
//
//  Created by Ozgur Ersoz on 2023-10-25.
//

import XCTest
import Dependencies
import DataSource
@testable import CalculatorFeature

final class CalculatorFeatureTests: XCTestCase {
    var viewModel = withDependencies {
        $0.btcClient.convertBtc = {
            PriceModel(data: .init(amount: "1000", base: "BTC", currency: "USD"))
        }
    } operation: {
        return CalculatorViewModel()
    }
    
    func testSumOfTwoValues() {
        viewModel.currentInput = "5"
        viewModel.operation = .arithmetic(.addition)
        viewModel.currentInput = "6"
        viewModel.calculate()
                
        XCTAssertEqual(viewModel.currentInput, "11.0")
    }
    
    func testSumOfThreeValues() {
        viewModel.currentInput = "5"
        viewModel.operation = .arithmetic(.addition)
        viewModel.currentInput = "6"
        viewModel.operation = .arithmetic(.addition)
        viewModel.currentInput = "5"
        viewModel.calculate()
        
        XCTAssertEqual(viewModel.currentInput, "16.0")
    }
    
    func testMultiplyOfThreeValues() {
        viewModel.currentInput = "5"
        viewModel.operation = .arithmetic(.multiplication)
        viewModel.currentInput = "5"
        viewModel.operation = .arithmetic(.multiplication)
        viewModel.currentInput = "5"
        viewModel.calculate()
        
        XCTAssertEqual(viewModel.currentInput, "125.0")
    }
    
    func testMinusTwoValues() {
        viewModel.currentInput = "15"
        viewModel.operation = .arithmetic(.subtraction)
        viewModel.currentInput = "5"
        viewModel.calculate()
        
        XCTAssertEqual(viewModel.currentInput, "10.0")
    }
    
    func testMultiplySumDivisionSubstractionArithmetic() {
        viewModel.currentInput = "5"
        viewModel.operation = .arithmetic(.multiplication)
        viewModel.currentInput = "10"
        viewModel.operation = .arithmetic(.addition)
        viewModel.currentInput = "1"
        viewModel.operation = .arithmetic(.division)
        viewModel.currentInput = "3"
        viewModel.calculate()
        XCTAssertEqual(viewModel.currentInput, "17.0")
    }
    
    func testSin() {
        viewModel.currentInput = "0.0"
        viewModel.operation = .trigonometric(.sin)
        XCTAssertEqual(viewModel.currentInput, "0.0")
    }
    
    func testCos() {
        viewModel.currentInput = "0.0"
        viewModel.operation = .trigonometric(.cos)
        XCTAssertEqual(viewModel.currentInput, "1.0")
        
    }
    
    func testBTCValue() async {
        viewModel.currentInput = "1"
        await viewModel.fetchBTCValue()
        XCTAssertEqual(viewModel.currentInput, "1000.0")
    }
}
