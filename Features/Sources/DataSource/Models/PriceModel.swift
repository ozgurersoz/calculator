//
//  File.swift
//  
//
//  Created by Ozgur Ersoz on 2023-10-25.
//

import Foundation

public struct PriceModel: Decodable {
    public let data: ResponseData
    
    public init(data: ResponseData) {
        self.data = data
    }
    
    public struct ResponseData: Decodable {
        public let amount: String
        public let base: String
        public let currency: String
        
        public init(amount: String, base: String, currency: String) {
            self.amount = amount
            self.base = base
            self.currency = currency
        }
    }
}
