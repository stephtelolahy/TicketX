//
//  Publisher+Utils.swift
//  TicketX
//
//  Created by TELOLAHY Hugues Stéphano on 09/10/2022.
//

import Combine

extension Publisher {
    
    static func empty() -> AnyPublisher<Output, Failure> {
        Empty().eraseToAnyPublisher()
    }
    
    static func just(_ output: Output) -> AnyPublisher<Output, Failure> {
        Just(output)
            .setFailureType(to: Failure.self)
            .eraseToAnyPublisher()
    }
    
    static func fail(_ error: Failure) -> AnyPublisher<Output, Failure> {
        Fail(error: error).eraseToAnyPublisher()
    }
    
    func sinkToResult(_ result: @escaping (Result<Output, Failure>) -> Void) -> AnyCancellable {
        sink(receiveCompletion: { completion in
            switch completion {
            case let .failure(error):
                result(.failure(error))
                
            default:
                break
            }
        }, receiveValue: { value in
            result(.success(value))
        })
    }
}
