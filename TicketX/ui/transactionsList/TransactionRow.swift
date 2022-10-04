//
//  TransactionRow.swift
//  TicketX
//
//  Created by TELOLAHY Hugues Stéphano on 04/10/2022.
//

import SwiftUI

struct TransactionRow: View {
    let transaction: Transaction
    
    var body: some View {
        Text(transaction.name)
    }
}

#if DEBUG
struct TransactionRow_Previews: PreviewProvider {
    static var transactions = PreviewData().transactions
    
    static var previews: some View {
        Group {
            TransactionRow(transaction: transactions[0])
            TransactionRow(transaction: transactions[1])
        }
        .previewLayout(.fixed(width: 300, height: 70))
    }
}
#endif
