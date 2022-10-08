//
//  TransactionsResponseDto.swift
//  TicketX
//
//  Created by TELOLAHY Hugues Stéphano on 09/10/2022.
//
// swiftlint:disable identifier_name

import Foundation

struct TransactionsResponseDto: Decodable {
    let transactions: [TransactionDto]?
}

struct TransactionDto: Decodable {
    let name: String?
    let type: String?
    let date: String?
    let message: String?
    let amount: AmountDto?
    let small_icon: IconDto?
    let large_icon: IconDto?
}

extension TransactionDto {
    struct AmountDto: Decodable {
        let value: Double?
        let currency: CurrencyDto?
    }
    
    struct CurrencyDto: Decodable {
        let symbol: String?
    }
    
    struct IconDto: Decodable {
        var url: String?
        let category: String?
    }
}
