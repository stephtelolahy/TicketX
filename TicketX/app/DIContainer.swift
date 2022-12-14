//
//  DIContainer.swift
//  TicketX
//
//  Created by TELOLAHY Hugues Stéphano on 06/10/2022.
//

import Foundation
import UIKit

/// Providing dependencies with a Service locator pattern
///
// swiftlint:disable force_unwrapping

struct DIContainer {
    let transactionRepository: TransactionRepositoryType
    
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
        configuration.urlCache = .shared
        return URLSession(configuration: configuration)
    }
    
    static func configureTransactionRepository(session: URLSession) -> TransactionRepositoryType {
        TransactionRepository(client: NetworkService(session: session,
                                                     baseURL: URL(string: AppConfig.baseURL)!))
    }
}

extension DIContainer {
    
    func provideTransactionsListViewModel() -> TransactionsListViewModel {
        TransactionsListViewModel(repository: transactionRepository)
    }
}
