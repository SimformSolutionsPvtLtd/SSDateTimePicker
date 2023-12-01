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
        DateFormatter.abbreviatedMonth.string(from: self)
    }
    
    public var dayOfWeekWithMonthAndDay: String {
        DateFormatter.dayOfWeekWithMonthAndDay.string(from: self)
    }
    
    public var fullMonth: String {
        DateFormatter.fullMonth.string(from: self)
    }
    
    public var timeOnlyWithPadding: String {
        DateFormatter.timeOnlyWithPadding.string(from: self)
    }
    
    public var monthDateYear: String {
        DateFormatter.monthDateYear.string(from: self)
    }
    
//    var yearStr: String {
//        DateFormatter.year.string(from: self)
//    }
    
    public var monthYear: String {
        DateFormatter.monthYear.string(from: self)
    }
    
    func getNextMonth() -> Date? {
        return Calendar.current.date(byAdding: .month, value: 1, to: self)
    }
    
    func getPreviousMonth() -> Date? {
        return Calendar.current.date(byAdding: .month, value: -1, to: self)
    }
    
    func getNextYear() -> Date? {
        return Calendar.current.date(byAdding: .year, value: 1, to: self)
    }
    
    func getPreviousYear() -> Date? {
        return Calendar.current.date(byAdding: .year, value: -1, to: self)
    }
    
    var year: Int {
        let components = Calendar.current.dateComponents([.year], from: self)
        return components.year ?? 2023
    }
}
