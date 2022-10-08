//
//  Transaction.swift
//  TicketX
//
//  Created by TELOLAHY Hugues Stéphano on 04/10/2022.
//

import Foundation

struct Transaction {
    let name: String
    let type: String
    let date: Date?
    let message: String?
    let amount: Amount
    let smallIcon: Icon
    let largeIcon: Icon
}

extension Transaction {
    struct Amount {
        let value: Double
        let currency: String
    }
    
    struct Icon {
        var url: String?
        let category: String
    }
}

extension Transaction: Identifiable {
    var id: String { "\(name) \(String(describing: date))" }
}
