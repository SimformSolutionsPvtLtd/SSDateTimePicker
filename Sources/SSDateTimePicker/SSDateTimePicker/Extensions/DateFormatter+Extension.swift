//
//  DateFormatter+Extension.swift
//  DateTimePicker
//
//  Created by Rizwana Desai on 24/11/23.
//

import Foundation

extension DateFormatter {
    
    // MARK: - Months List
    
    /// Provides an array of localized month names using the current locale.
    ///
    /// Example:
    /// ```
    /// let months = DateFormatter.monthsList
    /// print(months) // ["January", "February", ..., "December"]
    /// ```
    static var monthsList: [String] {
        let formatter = DateFormatter()
        let months = formatter.monthSymbols
        return months ?? []
    }
    
    // MARK: - Date Formatter with Format String
    
    /// Returns a date formatter instance configured with the specified format string.
    ///
    /// - Parameter formate: The format string for the desired date format.
    ///
    /// Example:
    /// ```swift
    /// let customDateFormatter = DateFormatter.configure(with: "yyyy-MM-dd HH:mm:ss")
    /// let formattedDate = customDateFormatter.string(from: Date())
    /// print(formattedDate) // Formatted date string using the specified format.
    /// ```
    ///
    /// - Returns: A `DateFormatter` instance with the specified date format.
    static func configure(with formate: String) -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = formate
        return formatter
    }
    
}
