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

struct LandmarkDetail_Previews: PreviewProvider {
    static var previews: some View {
        TransactionDetail(transaction: PreviewData.transactions[0])
    }
}
