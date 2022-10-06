//
//  TransactionMapper.swift
//  TicketX
//
//  Created by TELOLAHY Hugues Stéphano on 06/10/2022.
//

import Foundation

enum TransactionMapper {
    
    private enum Constant {
        static let serverDateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
    }
    
    static func map(dto: TransactionsResponseDto) -> [Transaction] {
        guard let transactionsDto = dto.transactions else {
            return []
        }
        
        return transactionsDto.compactMap {
            guard let smallIcon = $0.small_icon,
                  let largeIcon = $0.large_icon,
                  let amount = $0.amount,
                    let dateDto = $0.date else {
                return nil
            }
            
            return Transaction(name: $0.name ?? "",
                               type: $0.type ?? "",
                               date: DateUtils.date(from: dateDto, with: Constant.serverDateFormat),
                               message: $0.message,
                               amount: map(dto: amount),
                               smallIcon: map(dto: smallIcon),
                               largeIcon: map(dto: largeIcon))
        }
    }
    
    private static func map(dto: TransactionDto.IconDto) -> Transaction.Icon {
        Transaction.Icon(url: dto.url, category: dto.category ?? "")
    }
    
    private static func map(dto: TransactionDto.AmountDto) -> Transaction.Amount {
        Transaction.Amount(value: dto.value ?? 0, currency: dto.currency?.symbol ?? "")
    }
}
