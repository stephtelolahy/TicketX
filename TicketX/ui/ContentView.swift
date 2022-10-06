//
//  ContentView.swift
//  TicketX
//
//  Created by TELOLAHY Hugues Stéphano on 04/10/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TransactionsList(viewModel: DIContainer.default.provideTransactionsListViewModel())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Text("Hello, world!")
            .padding()
    }
}
