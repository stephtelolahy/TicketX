//
//  TransactionsList.swift
//  TicketX
//
//  Created by TELOLAHY Hugues Stéphano on 04/10/2022.
//

import SwiftUI
import Combine

struct TransactionsList: View {
    
    @ObservedObject var viewModel: TransactionsListViewModel
    
    var body: some View {
        NavigationView {
            content
                .navigationBarTitle("Transactions")
        }
    }
    
    @ViewBuilder private var content: some View {
        switch viewModel.transactions {
        case .notRequested:
            notRequestedView()
            
        case .loading:
            loadingView()
            
        case let .loaded(transactions):
            loadedView(transactions)
            
        case let .failed(error):
            failedView(error)
        }
    }
}

private extension TransactionsList {
    
    func notRequestedView() -> some View {
        Text("")
            .onAppear(perform: viewModel.loadTransactions)
    }
    
    func loadingView() -> some View {
        AnyView(ActivityIndicatorView().padding())
    }
    
    func failedView(_ error: Error) -> some View {
        ErrorView(error: error, retryAction: {
            viewModel.loadTransactions()
        })
    }
    
    func loadedView(_ transactions: [Transaction]) -> some View {
        List(transactions) { transaction in
            NavigationLink {
                TransactionDetail(transaction: transaction)
            } label: {
                TransactionRow(transaction: transaction)
            }
        }
        .padding(.bottom, 0)
    }
}

struct CountriesList_Previews: PreviewProvider {
    static var previews: some View {
        let repository = DIContainer.stub.transactionRepository
        let viewModel = TransactionsListViewModel(repository: repository)
        return TransactionsList(viewModel: viewModel)
    }
}
