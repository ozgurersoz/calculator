//
//  SwiftUIView.swift
//
//
//  Created by Ozgur Ersoz on 2023-10-23.
//

import SwiftUI
import UIComponents

struct ButtonView: View {
    let buttonType: ButtonType
    @ObservedObject var viewModel: CalculatorViewModel
    
    var body: some View {
        Button(
            action: {
                switch buttonType {
                    case .number(let int):
                        if viewModel.operation != nil {
                            if viewModel.clearCurrentInput {
                                viewModel.currentInput.removeAll()
                                viewModel.clearCurrentInput = false
                            }
                            viewModel.currentInput += int.description
                        } else {
                            if viewModel.calculationHasCompleted {
                                viewModel.currentInput.removeAll()
                                viewModel.calculationHasCompleted = false
                            }
                            viewModel.currentInput += int.description
                        }
                    case .text(let string):
                        viewModel.currentInput += string
                    case .arithmetic(let arithmetic):
                        viewModel.operation = .arithmetic(arithmetic)
                    case .trigonometric(let trigonometric):
                        viewModel.operation = .trigonometric(trigonometric)
                    case .outcome(let outcome):
                        switch outcome {
                            case .clean:
                                viewModel.clear()
                            case .equal:
                                viewModel.calculate()
                            case .btc:
                                viewModel.operation = .priceConversation(.btc)
                        }
                }
            },
            label: {
                Color.white
                    .overlay {
                        switch buttonType {
                            case .number(let int):
                                Text(int.description)
                            case .text(let string):
                                Text(string)
                            case .arithmetic(let arithmetic):
                                switch arithmetic {
                                    case .addition: Image(systemName: "plus")
                                    case .multiplication: Image(systemName: "multiply")
                                    case .division: Image(systemName: "divide")
                                    case .subtraction: Image(systemName: "minus")
                                }
                            case .trigonometric(let trigonometric):
                                switch trigonometric {
                                    case .sin: Text("sin")
                                    case .cos: Text("cos")
                                }
                            case .outcome(let outcome):
                                switch outcome {
                                    case .btc: 
                                        if viewModel.isLoading {
                                            ProgressView()
                                        } else {
                                            Image(systemName: "bitcoinsign")
                                        }
                                    case .clean: Text("C")
                                    case .equal: Image(systemName: "equal")
                                }
                        }
                    }
            }
        )
        .disabled(viewModel.isLoading)
        .buttonStyle(PressEffectButtonStyle())
    }
}

