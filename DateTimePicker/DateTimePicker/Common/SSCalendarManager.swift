//
//  SSCalendarManager.swift
//  DateTimePicker
//
//  Created by Rizwana Desai on 27/11/23.
//

import Foundation

public class SSCalendarManager: ObservableObject {
    
    @Published public private(set) var currentMonth: Date
    @Published public var selectedDate: Date? = nil
    
    @Published public private(set) var yearRange = [Int]()
    var configuration: SSCalendarConfiguration

    
    public init(currentMonth: Date, selectedDate: Date? = nil, configuration: SSCalendarConfiguration = SSCalendarConfiguration()) {
        self.currentMonth = currentMonth
        self.selectedDate = selectedDate
        self.configuration = configuration
    }
    
    func actionNext(for view: SelectionView) {
        switch view {
        case .date:
            currentMonth = currentMonth.getNextMonth() ?? currentMonth
        case .month:
            currentMonth = currentMonth.getNextYear() ?? currentMonth
        case .year:
            guard let year = self.yearRange.last else { return }
            self.updateYearRange(year: year+12)
        }
    }
    
    func actionPrev(for view: SelectionView) {
        switch view {
        case .date:
            currentMonth = currentMonth.getPreviousMonth() ?? currentMonth
        case .month:
            currentMonth = currentMonth.getPreviousYear() ?? currentMonth
        case .year:
            guard let year = self.yearRange.first else { return }
            self.updateYearRange(year: year-1)
        }
    }
    
    func isSelected(_ month: String) -> Bool {
        month.lowercased() == (selectedDate ?? currentMonth).fullMonth.lowercased()
    }
    
    func isSelected(_ year: Int) -> Bool {
        year == (selectedDate ?? currentMonth).year
    }
    
    func updateDateSelection(date: Date) {
        self.selectedDate = date
    }
    
    func updateMonthSelection(month: Int) {
        guard let selectedDate else {
            var component = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self.currentMonth)
            component.month = month
            self.currentMonth = Calendar.current.date(from: component) ?? currentMonth
            return
        }
        var component = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: selectedDate)
        component.month = month
        self.selectedDate = Calendar.current.date(from: component)
        self.currentMonth = self.selectedDate ?? currentMonth
    }
    
    func updateYearSelection(year: Int) {
        guard let selectedDate else {
            var component = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self.currentMonth)
            component.year = year
            self.currentMonth = Calendar.current.date(from: component) ?? currentMonth
            return
        }
        var component = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: selectedDate)
        component.year = year
        self.selectedDate = Calendar.current.date(from: component)
        self.currentMonth = self.selectedDate ?? currentMonth
    }
    
    func updateYearRange(year: Int) {
        let year = year
        let lowerBound = year - 11
        let upperBound = year
        self.yearRange = Array(lowerBound...upperBound)
    }
}
