
import Dependencies

public struct BTCClient {
    public var convertBtc: () async throws -> PriceModel
    
    public init(
        convertBtc: @escaping () async throws -> PriceModel
    ) {
        self.convertBtc = convertBtc
    }
}

extension BTCClient: TestDependencyKey {
    public static var testValue: BTCClient {
        Self(
            convertBtc: unimplemented()
        )
    }
}

public extension DependencyValues {
    var btcClient: BTCClient {
        get { self[BTCClient.self] }
        set { self[BTCClient.self] = newValue }
    }
}
