//
//  File.swift
//  
//
//  Created by Ozgur Ersoz on 2023-10-25.
//


import Foundation

public class NetworkManager {
    private let session = URLSession.shared
    private let baseURL = "https://api.coinbase.com/v2"
    
    public init() {}
    enum NetworkError: Error {
        case badURL
        case errorWithStatusCode(Int)
        case keyNotFound(missingKey: String)
    }
    
    private func createRequest(
        path: String,
        method: HTTPMethod,
        headers: [String: String]? = nil,
        body: Encodable? = nil
    ) throws -> URLRequest {
        guard let url = URL(string: "\(baseURL)\(path)") else {
            throw NetworkError.badURL
        }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        if let body {
            request.httpBody = try JSONEncoder().encode(body)
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        
        if let headers {
            headers.forEach({ key, value in
                request.addValue(value, forHTTPHeaderField: key)
            })
        }
        
        return request
    }
    
    private func decodeResponse<T: Decodable>(
        from data: Data,
        responseType: T.Type
    ) throws -> T {
        let decoder = JSONDecoder()
        do {
            return try decoder.decode(responseType, from: data)
        } catch let error as DecodingError {
            switch error {
                case .keyNotFound(let key, _):
                    throw NetworkError.keyNotFound(missingKey: key.stringValue)
                default:
                    throw NetworkError.keyNotFound(missingKey: error.localizedDescription)
            }
        }
    }
    
    public func performRequest<ResponseType: Decodable>(
        path: String,
        method: HTTPMethod,
        headers: [String: String]? = nil,
        responseType: ResponseType.Type,
        requestBody: Encodable? = nil
    ) async throws -> ResponseType {
        let request: URLRequest
        request = try createRequest(
            path: path,
            method: method,
            headers: headers,
            body: requestBody
        )
        let (data, urlResponse) = try await session.data(for: request)
        let httpResponse = urlResponse as? HTTPURLResponse
        
        switch httpResponse {
            case .none:
                throw NetworkError.errorWithStatusCode(999)
            case .some(let wrappedStatus):
                switch wrappedStatus.statusCode {
                    case 400...:
                        throw NetworkError.errorWithStatusCode(wrappedStatus.statusCode)
                    default:
                        let decodedResponse = try decodeResponse(from: data, responseType: responseType)
                        return decodedResponse
                }
        }
    }
}

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}
