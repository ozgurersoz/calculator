//
//  SwiftUIView.swift
//  
//
//  Created by Ozgur Ersoz on 2023-10-23.
//

import SwiftUI

public struct PressEffectButtonStyle: ButtonStyle {
    
    public init() {}
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
            .opacity(configuration.isPressed ? 0.6 : 1.0)
            .animation(.easeInOut, value: configuration.isPressed)
    }
}
