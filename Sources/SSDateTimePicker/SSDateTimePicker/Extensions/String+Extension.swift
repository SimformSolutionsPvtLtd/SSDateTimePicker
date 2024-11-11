//
//  String+Extension.swift
//  DateTimePicker
//
//  Created by Rizwana Desai on 12/12/23.
//

import Foundation

extension String {
    
    // MARK: - Localized String with Comment
    
    /// Returns a localized version of the string, using the NSLocalizedString function, with an optional comment.
    ///
    /// - Parameters:
    ///   - comment: An optional comment that can be used to provide context or additional information for translators.
    ///
    /// Example:
    /// ```
    /// let greeting = "Hello".localized(withComment: "User greeting")
    /// print(greeting) // Localized version of "Hello" with the specified comment.
    /// ```
    ///
    /// - Returns: A localized version of the string.
    func localized(withComment comment: String = "") -> String {
        return NSLocalizedString(self, comment: comment)
    }
    
}
