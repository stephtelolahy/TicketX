//
//  TransactionRepository.swift
//  TicketX
//
//  Created by TELOLAHY Hugues Stéphano on 04/10/2022.
//

import Combine

protocol TransactionRepositoryProtocol {
    func loadTransactions() -> AnyPublisher<[Transaction], Error>
}

struct TransactionRepository: TransactionRepositoryProtocol {
    
    func loadTransactions() -> AnyPublisher<[Transaction], Error> {
        fatalError("TODO: implement")
    }
}
