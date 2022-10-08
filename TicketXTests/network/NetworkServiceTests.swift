//
//  NetworkServiceTests.swift
//  TicketXTests
//
//  Created by TELOLAHY Hugues Stéphano on 09/10/2022.
//
// swiftlint:disable force_unwrapping

import XCTest
import Combine

class NetworkServiceTests: XCTestCase {
    private var sut: NetworkService!
    private var disposables = Set<AnyCancellable>()
    
    override func setUp() {
        disposables = Set<AnyCancellable>()
        sut = NetworkService(session: .mockedResponsesOnly, baseURL: URL(string: "https://my.service.com")!)
    }
    
    override func tearDown() {
        RequestMocking.removeAllMocks()
    }
    
    func test_loadFinishedSuccessfully() {
        // Given
        let requestURL = URL(string: "https://my.service.com/transactions.json")!
        let responseData = loadStub(named: "transactions")!
        RequestMocking.add(mock: MockedResponse(url: requestURL, result: .success(responseData)))
        
        let expectation = XCTestExpectation(description: "networkServiceExpectation")
        let resource = Resource<TransactionsResponseDto>(path: "/transactions.json")
        
        // When
        // Assert
        sut.request(resource)
            .sinkToResult { result in
                switch result {
                case let .success(value):
                    XCTAssertNotNil(value.transactions)
                    expectation.fulfill()
                    
                case let .failure(error):
                    XCTFail("Unexpected error: \(error)")
                }
            }
            .store(in: &disposables)
        
        wait(for: [expectation], timeout: 2)
    }
    
    func test_loadFailedWithInternalServerError() throws {
        // Given
        let requestURL = URL(string: "https://my.service.com/transactions.json")!
        let response = HTTPURLResponse(url: requestURL, statusCode: 500, httpVersion: nil, headerFields: nil)!
        RequestMocking.add(mock: try MockedResponse(url: requestURL, customResponse: response))
        
        let expectation = XCTestExpectation(description: "networkServiceExpectation")
        let resource = Resource<TransactionsResponseDto>(path: "/transactions.json")
        
        // When
        // Assert
        sut.request(resource)
            .sinkToResult { result in
                switch result {
                case .success:
                    XCTFail("Unexpected success")
                    
                case let .failure(error):
                    if let networkError = error as? NetworkError,
                       case NetworkError.httpCodeError(statusCode: 500, data: _) = networkError {
                        expectation.fulfill()
                    } else {
                        XCTFail("Unexpected error: \(error)")
                    }
                }
            }
            .store(in: &disposables)
        
        wait(for: [expectation], timeout: 2)
    }
    
    func test_loadFailedWithJsonParsingError() throws {
        // Given
        let requestURL = URL(string: "https://my.service.com/transactions.json")!
        let response = HTTPURLResponse(url: requestURL, statusCode: 200, httpVersion: nil, headerFields: nil)!
        RequestMocking.add(mock: try MockedResponse(url: requestURL, customResponse: response))
        
        let expectation = XCTestExpectation(description: "networkServiceExpectation")
        let resource = Resource<TransactionsResponseDto>(path: "/transactions.json")
        
        // When
        // Assert
        sut.request(resource)
            .sinkToResult { result in
                switch result {
                case .success:
                    XCTFail("Unexpected success")
                    
                case .failure:
                    expectation.fulfill()
                }
            }
            .store(in: &disposables)
        
        wait(for: [expectation], timeout: 2)
    }
}
