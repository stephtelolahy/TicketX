//
//  TransactionMapperTests.swift
//  TicketXTests
//
//  Created by TELOLAHY Hugues Stéphano on 08/10/2022.
//
// swiftlint:disable line_length

import XCTest

class TransactionMapperTests: XCTestCase {

    func test_MappingTransaction() {
        // Given
        let dto = TransactionsResponseDto(transactions: [
            TransactionDto(name: "Restos du coeur",
                           type: "donation",
                           date: "2021-03-07T14:04:45.000+01:00",
                           message: "Don à l'arrondi",
                           amount: TransactionDto.AmountDto(value: -0.07,
                                                            currency: TransactionDto.CurrencyDto(symbol: "€")),
                           small_icon: TransactionDto.IconDto(url: nil,
                                                              category: "meal_voucher"),
                           large_icon: TransactionDto.IconDto(url: "https://res.cloudinary.com/hbnjrwllw/image/upload/v1583240999/neobank/charity/cdaa7851-da33-4b3c-8e01-228c4b085ac3.png",
                                                              category: "donation"))
        ])
        
        // When
        let result = TransactionMapper.map(dto: dto)
        
        // Assert
        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result[0].name, "Restos du coeur")
        XCTAssertEqual(result[0].type, "donation")
        XCTAssertEqual(result[0].date, Date())
        XCTAssertEqual(result[0].message, "Don à l'arrondi")
        XCTAssertEqual(result[0].amount.value, -0.07)
        XCTAssertEqual(result[0].amount.currency, "€")
        XCTAssertEqual(result[0].smallIcon.category, "meal_voucher")
        XCTAssertNil(result[0].smallIcon.url)
        XCTAssertEqual(result[0].largeIcon.category, "donation")
        XCTAssertEqual(result[0].largeIcon.url, "https://res.cloudinary.com/hbnjrwllw/image/upload/v1583240999/neobank/charity/cdaa7851-da33-4b3c-8e01-228c4b085ac3.png")
    }
}
