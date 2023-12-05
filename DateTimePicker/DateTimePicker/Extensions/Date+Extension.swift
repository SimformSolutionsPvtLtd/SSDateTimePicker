//
//  Date+Extension.swift
//  DateTimePicker
//
//  Created by Rizwana Desai on 24/11/23.
//

import Foundation


extension Date {
    
    //MARK: - Date to String
    
    public var abbreviatedMonth: String {
        DateFormatter.dateFormatter(DateFormat.abbreviatedMonth).string(from: self)
    }
    
    public var dayOfWeekWithMonthAndDay: String {
        DateFormatter.dateFormatter(DateFormat.dayOfWeekWithMonthAndDay).string(from: self)
    }
    
    public var fullMonth: String {
        DateFormatter.dateFormatter(DateFormat.fullMonth).string(from: self)
    }
    
    public var timeOnlyWithPadding: String {
        DateFormatter.dateFormatter(DateFormat.timeOnlyWithPadding).string(from: self)
    }
    
    public var monthDateYear: String {
        DateFormatter.dateFormatter(DateFormat.monthDateYear).string(from: self)
    }

    public var monthYear: String {
        DateFormatter.dateFormatter(DateFormat.monthYear).string(from: self)
    }
    
    public func formatedString(_ format: String) -> String {
        DateFormatter.dateFormatter(format).string(from: self)
    }

    func getNextMonth(_ calender: Calendar) -> Date? {
        return calender.date(byAdding: .month, value: 1, to: self)
    }
    
    func getPreviousMonth(_ calender: Calendar) -> Date? {
        return calender.date(byAdding: .month, value: -1, to: self)
    }
    
    func getNextYear(_ calender: Calendar) -> Date? {
        return calender.date(byAdding: .year, value: 1, to: self)
    }
    
    func getPreviousYear(_ calender: Calendar) -> Date? {
        return calender.date(byAdding: .year, value: -1, to: self)
    }
    
    func year(_ calender: Calendar) -> Int {
        let components = calender.dateComponents([.year], from: self)
        return components.year ?? 2023
    }
    
}
