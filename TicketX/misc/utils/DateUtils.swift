//
//  DateUtils.swift
//  TicketX
//
//  Created by TELOLAHY Hugues Stéphano on 04/10/2022.
//
// swiftlint:disable force_unwrapping

import Foundation

enum DateUtils {
    static let dateFormatter = DateFormatter()
    
    /// Format Date with given template
    static func format(date: Date, with template: String) -> String {
        dateFormatter.dateFormat = template
        return dateFormatter.string(from: date)
    }
    
    /// Create Date from string with given template
    static func date(from string: String, with template: String) -> Date? {
        dateFormatter.dateFormat = template
        return dateFormatter.date(from: string)
    }
}

/// Creating Date from components
extension Date {
    
    init(year: Int, month: Int, day: Int, hour: Int, minute: Int, second: Int) {
        var components = DateComponents()
        components.year = year
        components.month = month
        components.day = day
        components.hour = hour
        components.minute = minute
        components.second = second
        self = Calendar.current.date(from: components)!
    }
}
