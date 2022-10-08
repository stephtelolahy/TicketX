//
//  NetworkService.swift
//  TicketX
//
//  Created by TELOLAHY Hugues Stéphano on 09/10/2022.
//

import Foundation
import Combine

struct NetworkService: NetworkServiceType {
    let session: URLSession
    let baseURL: URL
    
    func request<T: Decodable>(_ resource: Resource<T>) -> AnyPublisher<T, Error> {
        guard let request = resource.buildRequest(baseURL: baseURL) else {
            return .fail(NetworkError.invalidRequest)
        }
        
        return session.dataTaskPublisher(for: request)
            .mapError { _ in NetworkError.invalidRequest }
            .print()
            .flatMap { data, response -> AnyPublisher<Data, Error> in
                assert(!Thread.isMainThread)
                
                guard let response = response as? HTTPURLResponse else {
                    return .fail(NetworkError.invalidResponse)
                }
                
                guard 200..<300 ~= response.statusCode else {
                    return .fail(NetworkError.httpCodeError(statusCode: response.statusCode, data: data))
                }
                
                return .just(data)
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}

private extension Resource {
    func buildRequest(baseURL: URL) -> URLRequest? {
        var url = baseURL.appendingPathComponent(path)
        
        if let params = parameters {
            url = url.appending(params: params)
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = method
        request.allHTTPHeaderFields = headers
        
        return request
    }
}

private extension URL {
    func appending(params: [String: CustomStringConvertible]) -> URL {
        
        guard var urlComponents = URLComponents(string: absoluteString) else {
            return absoluteURL
        }
        
        var queryItems: [URLQueryItem] = urlComponents.queryItems ?? []
        
        for param in params {
            let queryItem = URLQueryItem(name: param.key, value: param.value.description)
            queryItems.append(queryItem)
        }
        
        urlComponents.queryItems = queryItems
        
        guard let url = urlComponents.url else {
            return self
        }
        
        return url
    }
}
