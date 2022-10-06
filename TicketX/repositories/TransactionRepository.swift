//
//  TransactionRepository.swift
//  TicketX
//
//  Created by TELOLAHY Hugues Stéphano on 04/10/2022.
//

import Combine

struct TransactionRepository: TransactionRepositoryProtocol {
    
    let client: HTTPClient
    
    func loadTransactions() -> AnyPublisher<[Transaction], Error> {
        client.request(TransactionsResponseDto.self,
                       path: "/transactions.json",
                       headers: ["Accept": "application/json"])
            .map({ TransactionMapper.map(dto: $0) })
            .eraseToAnyPublisher()
    }
}
