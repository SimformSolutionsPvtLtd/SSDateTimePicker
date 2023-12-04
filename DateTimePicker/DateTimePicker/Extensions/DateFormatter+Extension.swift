//
//  DateFormatter+Extension.swift
//  DateTimePicker
//
//  Created by Rizwana Desai on 24/11/23.
//

import Foundation

extension DateFormatter {
    
    static var monthsList: [String] {
        let formatter = DateFormatter()
        let months = formatter.monthSymbols
        return months ?? []
    }
    
    static func dateFormatter(_ formate: String) -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = formate
        return formatter
    }

}

public struct DateFormat {
    
    public static let abbreviatedMonth = "MMM" // Dec
    public static let dayOfWeekWithMonthAndDay = "EEEE MMMM d" // Friday December 3
    public static let fullMonth = "MMMM" // December
    public static let monthYear = "MMMM, yyyy" // December, 2023
    public static let monthDateYear = "MMM d, yyyy" // Jun 3, 2023
    public static let dateMonthYear = "d MMM, yyyy" // 3 Jun, 2023
    public static let dateMonthYearFull = "dd MMMM, yyyy" // 03 December, 2023
    public static let monthDateYearFull = "MMMM dd, yyyy" // December 03, 2023
    public static let yearMonthDate = "yyyy-MM-dd" // 2023-06-03
    public static let shortMonthYear = "MMM yyyy" // Jun 2023
    public static let dayMonthYear = "EEEE, d MMM, yyyy" // Monday, 3 Jun, 2023
    public static let fullDate = "EEEE, MMMM d, yyyy" // Monday, Jun 03, 2023
    public static let timeOnlyWithPadding = "h:mm a" // 12:45 PM
    
}
