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
