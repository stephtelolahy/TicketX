//
//  TransactionRepositoryProtocol.swift
//  TicketX
//
//  Created by TELOLAHY Hugues Stéphano on 08/10/2022.
//

import Combine

protocol TransactionRepositoryProtocol {
    func loadTransactions() -> AnyPublisher<[Transaction], Error>
}
