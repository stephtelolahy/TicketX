//
//  DIContainer.swift
//  TicketX
//
//  Created by TELOLAHY Hugues Stéphano on 06/10/2022.
//
// swiftlint:disable line_length

import Foundation
import UIKit

/// Providing dependencies with a Service locator pattern
///

// TODO: use Resolver
struct DIContainer {
    let transactionRepository: TransactionRepositoryProtocol
    
    static let `default` = initialize()
}

private extension DIContainer {
    
    static func initialize() -> DIContainer {
        let session = configureURLSession()
        let transactionRepository = configureTransactionRepository(session: session)
        return DIContainer(transactionRepository: transactionRepository)
    }
    
    static func configureURLSession() -> URLSession {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 60
        configuration.timeoutIntervalForResource = 120
        configuration.waitsForConnectivity = true
        configuration.httpMaximumConnectionsPerHost = 5
        configuration.requestCachePolicy = .returnCacheDataElseLoad
        configuration.urlCache = .shared
        return URLSession(configuration: configuration)
    }
    
    static func configureTransactionRepository(session: URLSession) -> TransactionRepositoryProtocol {
        TransactionRepository(client: HTTPClient(session: session,
                                                 baseURL: "https://gist.githubusercontent.com/Aurazion/365d587f5917d1478bf03bacabdc69f3/raw/3c92b70e1dc808c8be822698f1cbff6c95ba3ad3"))
    }
}

extension DIContainer {
    
    func provideTransactionsListViewModel() -> TransactionsListViewModel {
        TransactionsListViewModel(repository: transactionRepository)
    }
}
