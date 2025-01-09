//
//  Date+Extension.swift
//  DateTimePicker
//
//  Created by Rizwana Desai on 24/11/23.
//

import Foundation


extension Date {
    
    // MARK: - Formatted Date Properties
    
    /// Abbreviated month representation of the date (e.g., "Dec").
    public var abbreviatedMonth: String {
        DateFormatter.configure(with: DateFormat.abbreviatedMonth).string(from: self)
    }
    
    /// Full date with day of the week, month, and day representation (e.g., "Friday December 3").
    public var dayOfWeekWithMonthAndDay: String {
        DateFormatter.configure(with: DateFormat.dayOfWeekWithMonthAndDay).string(from: self)
    }
    
    /// Full month representation of the date (e.g., "December").
    public var fullMonth: String {
        DateFormatter.configure(with: DateFormat.fullMonth).string(from: self)
    }
    
    /// Time-only representation with padding (e.g., "12:45 PM").
    public var timeOnlyWithPadding: String {
        DateFormatter.configure(with: DateFormat.timeOnlyWithPadding).string(from: self)
    }
    
    /// Month, day, and year representation (e.g., "Jun 3, 2023").
    public var monthDateYear: String {
        DateFormatter.configure(with: DateFormat.monthDateYear).string(from: self)
    }
    
    /// Month and year representation (e.g., "December, 2023").
    public var monthYear: String {
        DateFormatter.configure(with: DateFormat.monthYear).string(from: self)
    }
    
    // MARK: - Custom Formatted Date
    
    /// Returns a custom-formatted string representation of the date.
    ///
    /// - Parameter format: The format string for the desired date format.
    /// - Returns: A string representation of the date in the specified format.
    public func formatedString(_ format: String) -> String {
        DateFormatter.configure(with: format).string(from: self)
    }
    
    // MARK: - Date Calculations
    
    /// Returns the date of the next month.
    func getNextMonth(_ calender: Calendar) -> Date? {
        return calender.date(byAdding: .month, value: 1, to: self)
    }
    
    /// Returns the date of the previous month.
    func getPreviousMonth(_ calender: Calendar) -> Date? {
        return calender.date(byAdding: .month, value: -1, to: self)
    }
    
    /// Returns the date of the next year.
    func getNextYear(_ calender: Calendar) -> Date? {
        return calender.date(byAdding: .year, value: 1, to: self)
    }
    
    /// Returns the date of the previous year.
    func getPreviousYear(_ calender: Calendar) -> Date? {
        return calender.date(byAdding: .year, value: -1, to: self)
    }
    
    /// Returns the year of the date.
    ///
    /// - Parameter calender: The calendar to use for the date components.
    /// - Returns: The year of the date.
    func year(_ calender: Calendar) -> Int {
        let components = calender.dateComponents([.year], from: self)
        return components.year ?? 2023
    }
    
}
