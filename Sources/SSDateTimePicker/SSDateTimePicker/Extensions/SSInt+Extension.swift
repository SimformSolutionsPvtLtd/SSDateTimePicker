//
//  Int+Extension.swift
//  DateTimePicker
//
//  Created by Rizwana Desai on 06/12/23.
//

import Foundation

extension Int {
    
    // MARK: - Formatted Time String
    
    /// Converts an integer representing time (e.g., hours, minutes, seconds) into a two-digit formatted string.
    ///
    /// This extension is useful for ensuring a consistent two-digit representation, adding leading zeros if necessary.
    ///
    /// Example:
    /// ```
    /// let hour = 8
    /// let formattedHour = hour.formattedTime // "08"
    /// ```
    var formattedTime: String {
        String(format: "%02d", self)
    }
    
}
