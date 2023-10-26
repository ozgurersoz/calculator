//
//  File.swift
//
//
//  Created by Ozgur Ersoz on 2023-10-23.
//

import Foundation
import Dependencies
import DataSource

class CalculatorViewModel: ObservableObject {
    @Dependency(\.btcClient) var btcClient: BTCClient
    
    @Published var isLoading: Bool = false
    @Published var input1: String = ""
    @Published var input2: String = ""
    @Published var operation: Operation? {
        didSet {
            switch operation {
                case .arithmetic: 
                    if input1.isEmpty == false, input2.isEmpty == false {
                        calculate(previousOperation: oldValue)
                    }
                case .trigonometric:
                    calculate()
                case .priceConversation:
                    if let oldValue {
                        calculate(previousOperation: oldValue)
                    }
                    calculate()
                case .none: break
            }
            clearCurrentInput = true
        }
    }
    
    @Published var currentInput: String = "" {
        didSet {
            if input1.isEmpty {
                input1 = currentInput
            } else {
                input2 = currentInput
            }
        }
    }

    var calculationHasCompleted: Bool = false
    var clearCurrentInput = false
    
    func calculate(previousOperation: Operation? = nil) {
        guard var operation else {
            print("no operation")
            return
        }
        
        if let previousOperation {
            operation = previousOperation
        }
        
        switch operation {
            case .arithmetic(let arithmetic):
                guard let number1 = Double(input1), let number2 = Double(input2) else {
                    return
                }
                let result = Calculator.arithmetic(
                    x: number1, y: number2, arithmetic: arithmetic
                )
                if previousOperation == nil {
                    self.operation = nil
                }
                calculationHasCompleted = true
                currentInput = result.description
                input1 = currentInput
                input2.removeAll()
            case .trigonometric(let trigonometric):
                guard let number1 = Double(input1) else { return }
                let result = Calculator.trigonometric(
                    x: number1,
                    trigonometric: trigonometric
                )
                self.operation = nil
                calculationHasCompleted = true
                currentInput = result.description
                input1 = currentInput
                input2.removeAll()
            case .priceConversation(let conv):
                switch conv {
                    case .btc:
                        Task { @MainActor in
                            await fetchBTCValue()
                        }
                }
        }
    }
    
    func clear() {
        input1.removeAll()
        input2.removeAll()
        currentInput.removeAll()
        calculationHasCompleted = false
        operation = nil
        clearCurrentInput = false
    }
    
    func fetchBTCValue() async {
        guard let count = Double(currentInput) else { return }
        isLoading = true
        do {
            let price = try await btcClient.convertBtc()
            if let amount = Double(price.data.amount) {
                currentInput = (count * amount).description
            }
            input1 = currentInput
            input2.removeAll()
        } catch {
            print(error)
            // Handle error
        }
        isLoading = false
    }
}

extension CalculatorViewModel {
    enum Operation {
        case arithmetic(Calculator.Arithmetic)
        case trigonometric(Calculator.Trigonometric)
        case priceConversation(PriceConversation)
        
        enum PriceConversation {
            case btc
        }
    }
}
