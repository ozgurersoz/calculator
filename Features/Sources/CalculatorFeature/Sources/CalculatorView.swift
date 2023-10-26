//
//  SwiftUIView.swift
//  
//
//  Created by Ozgur Ersoz on 2023-10-23.
//

import SwiftUI

public struct CalculatorView: View {
    @StateObject var viewModel = CalculatorViewModel()
    
    public init() {}
    
    public var body: some View {
        VStack {
            GeometryReader { geometry in
                VStack {
                    Spacer()
                    TextField("\(viewModel.currentInput)", text: $viewModel.currentInput)

                    .multilineTextAlignment(.trailing)
                    
                    VStack(spacing: 2) {
                        let itemSize4Columns = ((geometry.size.width - 6) / 4)
                        HStack(spacing: 2) {
                            Group {
                                ButtonView(buttonType: .outcome(.clean), viewModel: viewModel)
                                ButtonView(buttonType: .trigonometric(.cos), viewModel: viewModel)
                                ButtonView(buttonType: .trigonometric(.sin), viewModel: viewModel)
                                ButtonView(buttonType: .arithmetic(.addition), viewModel: viewModel)
                            }
                            .frame(width: itemSize4Columns)
                        }
                        .frame(height: itemSize4Columns)
                        HStack(spacing: 2) {
                            Group {
                                ButtonView(buttonType: .number(1), viewModel: viewModel)
                                ButtonView(buttonType: .number(2), viewModel: viewModel)
                                ButtonView(buttonType: .number(3), viewModel: viewModel)
                                ButtonView(buttonType: .arithmetic(.subtraction), viewModel: viewModel)
                            }
                            .frame(width: itemSize4Columns)
                        }
                        .frame(height: itemSize4Columns)
                        HStack(spacing: 2) {
                            Group {
                                ButtonView(buttonType: .number(4), viewModel: viewModel)
                                ButtonView(buttonType: .number(5), viewModel: viewModel)
                                ButtonView(buttonType: .number(6), viewModel: viewModel)
                                ButtonView(buttonType: .arithmetic(.division), viewModel: viewModel)
                            }
                            .frame(width: itemSize4Columns)
                        }
                        .frame(height: itemSize4Columns)
                        HStack(spacing: 2) {
                            Group {
                                ButtonView(buttonType: .number(7), viewModel: viewModel)
                                ButtonView(buttonType: .number(8), viewModel: viewModel)
                                ButtonView(buttonType: .number(9), viewModel: viewModel)
                                ButtonView(buttonType: .arithmetic(.multiplication), viewModel: viewModel)
                            }
                            .frame(width: itemSize4Columns)
                        }
                        .frame(height: itemSize4Columns)
                        HStack(spacing: 2) {
                            Group {
                                ButtonView(buttonType: .number(0), viewModel: viewModel)
                                ButtonView(buttonType: .text("."), viewModel: viewModel)
                                ButtonView(buttonType: .outcome(.btc), viewModel: viewModel)
                                ButtonView(buttonType: .outcome(.equal), viewModel: viewModel)
                            }
                            .frame(width: itemSize4Columns)
                        }
                        .frame(height: itemSize4Columns)

                    }
                    .padding(.top, 2)
                    .background(Color.gray)
                }
            }
        }
        
    }
}

#if DEBUG
#Preview {
    CalculatorView()
}
#endif
