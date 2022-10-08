//
//  TransactionRepositoryType.swift
//  TicketX
//
//  Created by TELOLAHY Hugues Stéphano on 08/10/2022.
//

import Combine

protocol TransactionRepositoryType {
    func loadTransactions() -> AnyPublisher<[Transaction], Error>
}
