//
//  BTCClient+Live.swift
//  Calculator
//
//  Created by Ozgur Ersoz on 2023-10-25.
//

import Foundation
import DataSource
import Dependencies

extension BTCClient: DependencyKey {
    public static var liveValue: BTCClient {
        let networkManager = NetworkManager()
        return Self(
            convertBtc: {
                try await networkManager.performRequest(
                    path: "/prices/BTC-USD/buy",
                    method: .get,
                    responseType: PriceModel.self
                )
            }
        )
    }
}
