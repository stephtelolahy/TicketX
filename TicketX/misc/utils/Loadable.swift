//
//  Loadable.swift
//  TicketX
//
//  Created by TELOLAHY Hugues Stéphano on 04/10/2022.
//

/// Wrapper for a loadable data
/// Typically used as a view state
///
enum Loadable<T> {
    case notRequested
    case loading
    case loaded(T)
    case failed(Error)
}
