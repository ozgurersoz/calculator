//
//  File.swift
//  
//
//  Created by Ozgur Ersoz on 2023-10-24.
//

import Foundation

public struct Calculator {
    public static func arithmetic(
        x: Double,
        y: Double,
        arithmetic: Arithmetic
    ) -> Double {
        switch arithmetic {
            case .addition:
                return x + y
            case .subtraction:
                return x - y
            case .multiplication:
                return x * y
            case .division:
                return x / y
        }
    }
    
    public static func trigonometric(
        x: Double,
        trigonometric function: Trigonometric
    ) -> Double {
        switch function {
            case .sin: sin(x)
            case .cos: cos(x)
        }
    }
}

public extension Calculator {
    enum Arithmetic {
        case addition, subtraction, multiplication, division
    }
    
    enum Trigonometric {
        case sin, cos
    }
}
