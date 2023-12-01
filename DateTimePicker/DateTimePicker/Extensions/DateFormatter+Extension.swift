//
//  DateFormatter+Extension.swift
//  DateTimePicker
//
//  Created by Rizwana Desai on 24/11/23.
//

import Foundation

extension DateFormatter {

    static var abbreviatedMonth: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM"
        return formatter
    }

    static var dayOfWeekWithMonthAndDay: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE MMMM d"
        return formatter
    }

    static var fullMonth: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM"
        return formatter
    }

    static let timeOnlyWithPadding: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        return formatter
    }()

    static var year: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        return formatter
    }
    
    static var monthYear: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM, yyyy"
        return formatter
    }
    
    static var monthDateYear: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy"
        return formatter
    }
    
    static var monthsList: [String] {
        let formatter = DateFormatter()
        let months = formatter.monthSymbols
        return months ?? []
    }

}

public struct DateFormat {
    
    public static let abbreviatedMonth = "MMM"
    public static let dayOfWeekWithMonthAndDay = "EEEE MMMM d"
    public static let fullMonth = "MMMM"
    public static let timeOnlyWithPadding = "h:mm a"
    public static let monthYear = "MMMM, yyyy"
    public static let monthDateYear = "MMM d, yyyy"
    
}
