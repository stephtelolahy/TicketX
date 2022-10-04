//
//  TransactionDetail.swift
//  TicketX
//
//  Created by TELOLAHY Hugues Stéphano on 04/10/2022.
//

import SwiftUI

struct TransactionDetail: View {
    let transaction: Transaction
    
    var body: some View {
        Text(transaction.name)
    }
}

#if DEBUG
struct LandmarkDetail_Previews: PreviewProvider {
    static let transactions = PreviewData().transactions
    
    static var previews: some View {
        TransactionDetail(transaction: transactions[0])
    }
}
#endif
