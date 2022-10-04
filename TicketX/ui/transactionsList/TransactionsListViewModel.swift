//
//  TransactionsListViewModel.swift
//  TicketX
//
//  Created by TELOLAHY Hugues Stéphano on 04/10/2022.
//

import Combine

extension TransactionsList {
    
    class ViewModel: ObservableObject {
        
        // MARK: - State
        
        @Published var transactions: Loadable<[Transaction]> = .notRequested
        
        // MARK: - Dependencies
        
        private let repository: TransactionRepositoryProtocol
        
        // MARK: - Properties
        
        private var disposables = Set<AnyCancellable>()
        
        // MARK: - Init
        
        init(repository: TransactionRepositoryProtocol) {
            self.repository = repository
        }
        
        // MARK: - Events
        
        func loadTransactions() {
            transactions = .loading
            repository.loadTransactions()
                .sink(receiveCompletion: { [weak self] completion in
                    switch completion {
                    case .finished:
                        break
                        
                    case let .failure(error):
                        self?.transactions = .failed(error)
                    }
                }, receiveValue: { [weak self] value in
                    self?.transactions = .loaded(value)
                })
                .store(in: &disposables)
        }
    }
}
