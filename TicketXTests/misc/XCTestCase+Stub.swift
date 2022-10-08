//
//  XCTestCase+Stub.swift
//  TicketXTests
//
//  Created by TELOLAHY Hugues Stéphano on 09/10/2022.
//

import XCTest

extension XCTestCase {
    func loadStub(named fileName: String) -> Data? {
        let bundle = Bundle(for: classForCoder)
        guard let url = bundle.url(forResource: fileName, withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            return nil
        }
        
        return data
    }
}
