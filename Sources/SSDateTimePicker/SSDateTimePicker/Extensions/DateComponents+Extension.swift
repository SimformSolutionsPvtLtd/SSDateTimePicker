//
//  DateComponents+Extension.swift
//  DateTimePicker
//
//  Created by Rizwana Desai on 24/11/23.
//

import Foundation

extension DateComponents {
    
    // MARK: - Every Day Date Components
    
    /// Represents a `DateComponents` instance with zeroed hours, minutes, and seconds,
    /// effectively representing the concept of "every day."
    ///
    /// Example:
    /// ```swift
    /// let dailyResetTime = DateComponents.everyDay
    /// let nextResetDate = Calendar.current.date(byAdding: dailyResetTime, to: Date())
    /// ```
    ///
    /// - Returns: A `DateComponents` instance representing midnight, the start of every day.
    static var everyDay: DateComponents {
        DateComponents(hour: 0, minute: 0, second: 0)
    }
    
}
