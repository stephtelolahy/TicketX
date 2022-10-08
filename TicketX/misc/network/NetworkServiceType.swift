//
//  NetworkServiceType.swift
//  TicketX
//
//  Created by TELOLAHY Hugues Stéphano on 08/10/2022.
//

import Foundation
import Combine

/// API Client
///
protocol NetworkServiceType {
    
    @discardableResult
    func request<T>(_ resource: Resource<T>) -> AnyPublisher<T, Error>
}

/// API Specification
///
struct Resource<T: Decodable> {
    let path: String
    var method: HTTPMethod = .get
    var parameters: [String: CustomStringConvertible]?
    var headers: [String: String]?
}

typealias HTTPMethod = String

extension HTTPMethod {
    static let get = "GET"
    static let post = "POST"
}

/// Network service errors
///
enum NetworkError: Error {
    case invalidRequest
    case invalidResponse
    case httpCodeError(statusCode: Int, data: Data)
    case jsonDecodingError(error: Error)
}
