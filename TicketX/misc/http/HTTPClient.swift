//
//  HTTPClient.swift
//  TicketX
//
//  Created by TELOLAHY Hugues Stéphano on 06/10/2022.
//

import Foundation
import Combine

struct HTTPClient {
    let session: URLSession
    let baseURL: String
    
    func request<T: Decodable>(_ type: T.Type,
                               path: String,
                               method: HTTPMethod = .get,
                               headers: [String: String]? = nil) -> AnyPublisher<T, Error> {
        do {
            let request = try urlRequest(path: path, method: method, headers: headers)
            return session
                .dataTaskPublisher(for: request)
                .requestJSON(httpCodes: .success)
        } catch {
            return Fail<T, Error>(error: error).eraseToAnyPublisher()
        }
    }
}

private extension HTTPClient {
    
    func urlRequest(path: String, method: HTTPMethod, headers: [String: String]?) throws -> URLRequest {
        guard let url = URL(string: baseURL + path) else {
            throw APIError.invalidURL
        }
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.allHTTPHeaderFields = headers
        return request
    }
}

// MARK: - Helpers

extension Publisher where Output == URLSession.DataTaskPublisher.Output {
    func requestData(httpCodes: HTTPCodes = .success) -> AnyPublisher<Data, Error> {
        tryMap {
            assert(!Thread.isMainThread)
            guard let code = ($0.1 as? HTTPURLResponse)?.statusCode else {
                throw APIError.unexpectedResponse
            }
            guard httpCodes.contains(code) else {
                throw APIError.httpCode(code)
            }
            return $0.0
        }
        .extractUnderlyingError()
        .eraseToAnyPublisher()
    }
}

private extension Publisher where Output == URLSession.DataTaskPublisher.Output {
    
    func requestJSON<T>(httpCodes: HTTPCodes) -> AnyPublisher<T, Error> where T: Decodable {
        requestData(httpCodes: httpCodes)
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

typealias HTTPCode = Int
typealias HTTPCodes = Range<HTTPCode>

extension HTTPCodes {
    static let success = 200 ..< 300
}

typealias HTTPMethod = String

extension HTTPMethod {
    static let get = "GET"
}

enum APIError: Swift.Error {
    case invalidURL
    case httpCode(HTTPCode)
    case unexpectedResponse
    case imageDeserialization
}

extension APIError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
            
        case let .httpCode(code):
            return "Unexpected HTTP code: \(code)"
            
        case .unexpectedResponse:
            return "Unexpected response from the server"
            
        case .imageDeserialization:
            return "Cannot deserialize image from Data"
        }
    }
}
