//
//  PreviewData.swift
//  TicketX
//
//  Created by TELOLAHY Hugues Stéphano on 04/10/2022.
//
// swiftlint:disable line_length

import Foundation
import Combine

/// Providing Preview Data
///
extension DIContainer {
    static var stub: Self {
        DIContainer(transactionRepository: StubTransactionRepository())
    }
}

private struct StubTransactionRepository: TransactionRepositoryProtocol {
    func loadTransactions() -> AnyPublisher<[Transaction], Error> {
        Just(PreviewData.transactions)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}

enum PreviewData {
    
    static var transactions: [Transaction] {
        [
            Transaction(name: "Restos du coeur",
                        type: "donation",
                        date: Date.now.addingTimeInterval(1),
                        message: "Don à l'arrondi",
                        amount: Transaction.Amount(value: -0.07, currency: "€"),
                        smallIcon: Transaction.Icon(category: "meal_voucher"),
                        largeIcon: Transaction.Icon(url: "https://res.cloudinary.com/hbnjrwllw/image/upload/v1583240999/neobank/charity/cdaa7851-da33-4b3c-8e01-228c4b085ac3.png", category: "donation")),
            Transaction(name: "Sushi WA",
                        type: "meal_voucher",
                        date: Date.now.addingTimeInterval(2),
                        message: nil,
                        amount: Transaction.Amount(value: 18.63, currency: "€"),
                        smallIcon: Transaction.Icon(category: "meal_voucher"),
                        largeIcon: Transaction.Icon(category: "sushi"))
        ]
    }
}
