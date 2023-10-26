//
//  File.swift
//  
//
//  Created by Ozgur Ersoz on 2023-10-23.
//

import Foundation
import DataSource

enum ButtonType {
    case number(Int)
    case text(String)
    case arithmetic(Calculator.Arithmetic)
    case trigonometric(Calculator.Trigonometric)
    case outcome(Outcome)
    
    enum Outcome {
        case equal, btc, clean
    }
}

