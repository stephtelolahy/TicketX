//
//  TransactionRepository.swift
//  TicketX
//
//  Created by TELOLAHY Hugues Stéphano on 04/10/2022.
//
import Foundation
import Combine

struct TransactionRepository: TransactionRepositoryType {
    let client: NetworkServiceType
    
    func loadTransactions() -> AnyPublisher<[Transaction], Error> {
        client.request(.transactions())
            .map({ TransactionMapper.map(dto: $0) })
            .eraseToAnyPublisher()
    }
}

private extension Resource {
    static func transactions() -> Resource<TransactionsResponseDto> {
        Resource<TransactionsResponseDto>(path: "/transactions.json",
                                          headers: ["Accept": "application/json"])
    }
}
