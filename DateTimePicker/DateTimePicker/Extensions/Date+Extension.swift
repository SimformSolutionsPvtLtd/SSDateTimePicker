//
//  Date+Extension.swift
//  DateTimePicker
//
//  Created by Rizwana Desai on 24/11/23.
//

import Foundation


extension Date {
    
    //MARK: - Date to String
    var abbreviatedMonth: String {
        DateFormatter.abbreviatedMonth.string(from: self)
    }
    
    var dayOfWeekWithMonthAndDay: String {
        DateFormatter.dayOfWeekWithMonthAndDay.string(from: self)
    }
    
    var fullMonth: String {
        DateFormatter.fullMonth.string(from: self)
    }
    
    var timeOnlyWithPadding: String {
        DateFormatter.timeOnlyWithPadding.string(from: self)
    }
    
    var year: String {
        DateFormatter.year.string(from: self)
    }
    
    var monthYear: String {
        DateFormatter.monthYear.string(from: self)
    }
    
    func getNextMonth() -> Date? {
        return Calendar.current.date(byAdding: .month, value: 1, to: self)
    }
    
    func getPreviousMonth() -> Date? {
        return Calendar.current.date(byAdding: .month, value: -1, to: self)
    }
}
