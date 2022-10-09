//
//  MockedResponse.swift
//  TicketX
//
//  Created by TELOLAHY Hugues Stéphano on 09/10/2022.
//
import Foundation

/// Specification of a stubbed HTTP response for a specific request
struct MockedResponse {
    let url: URL
    let result: Result<Data, Swift.Error>
    let httpCode: Int
    let headers: [String: String]
    let loadingTime: TimeInterval
    let customResponse: URLResponse?
}

extension MockedResponse {
    
    init<T>(url: URL,
            result: Result<T, Swift.Error>,
            httpCode: Int = 200,
            headers: [String: String] = ["Content-Type": "application/json"],
            loadingTime: TimeInterval = 0.1
    ) throws where T: Encodable {
        self.url = url
        switch result {
        case let .success(value):
            self.result = .success(try JSONEncoder().encode(value))
            
        case let .failure(error):
            self.result = .failure(error)
        }
        self.httpCode = httpCode
        self.headers = headers
        self.loadingTime = loadingTime
        customResponse = nil
    }
    
    init(url: URL, customResponse: URLResponse) throws {
        self.url = url
        result = .success(Data())
        httpCode = 200
        headers = [String: String]()
        loadingTime = 0
        self.customResponse = customResponse
    }
    
    init(url: URL, result: Result<Data, Swift.Error>) {
        self.url = url
        self.result = result
        httpCode = 200
        headers = [String: String]()
        loadingTime = 0
        customResponse = nil
    }
}
