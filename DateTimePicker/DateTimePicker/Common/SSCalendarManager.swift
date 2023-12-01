//
//  SSCalendarManager.swift
//  DateTimePicker
//
//  Created by Rizwana Desai on 27/11/23.
//

import Foundation
import SwiftUI
import Combine

public typealias Event<T> = PassthroughSubject<T, Never>


public protocol DatePickerDataSource {
    
    func datePicker(backgroundColorOpacityForDate date: Date) -> Double
    func datePicker(canSelectDate date: Date) -> Bool
    func datePicker(viewForSelectedDate date: Date, dimensions size: CGSize) -> AnyView
    
}

public extension DatePickerDataSource {
    
    func datePicker(backgroundColorOpacityForDate date: Date) -> Double { 1 }
    func datePicker(canSelectDate date: Date) -> Bool { true }
    func datePicker(viewForSelectedDate date: Date, dimensions size: CGSize) -> AnyView {
        AnyView(EmptyView())
    }
    
}


public class SSCalendarManager: ObservableObject {
    
    //MARK: - Property

    @Published public private(set) var currentMonth: Date
    @Published public var selectedDate: Date? = nil
    @Published public private(set) var yearRange = [Int]()
    @Published public var datasource: DatePickerDataSource?
    @Published public var selectedDates: [Date]? = nil
    @Published public var startDate: Date? = nil
    @Published public var endDate: Date? = nil
    
    private var lastCurrentMonth: Date
    private var lastSelectedDate: Date?
    
    public var configuration: SSCalendarConfiguration
    public var onSingleDateSelection = Event<Date>()
    public var onMultipleDateSelection = Event<[Date]>()
    public var onDateRangeSelection = Event<(Date, Date)>()

    //MARK: - init

    public init(currentMonth: Date, selectedDate: Date? = nil, configuration: SSCalendarConfiguration = SSCalendarConfiguration()) {
        self.currentMonth = currentMonth
        self.selectedDate = selectedDate
        self.configuration = configuration
        self.lastCurrentMonth = currentMonth
        self.lastSelectedDate = selectedDate
    }
    
    //MARK: - Methods
    
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
        if configuration.allowMultipleSelection {
            if selectedDates == nil  {
                self.selectedDates = []
            }
            self.selectedDates?.append(date)
        } else if configuration.allowRangeSelection {
            self.updateRangeSelection(date: date)
        } else {
            self.selectedDate = date
        }
    }
    
    func updateRangeSelection(date: Date) {
        
        if let startDate = startDate , date >= configuration.calendar.startOfDay(for: startDate) {
            endDate = date
        } else {
            startDate = date
        }
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
        
    func selectionCanceled(for view: SelectionView) {
        switch view {
        case .date:
            self.selectedDate = lastSelectedDate
        case .month:
            self.currentMonth = lastCurrentMonth
        case .year:
            self.currentMonth = lastCurrentMonth
        }
    }
    
    func selectionConfirmed(for view: SelectionView) {
        switch view {
        case .date:
            lastSelectedDate = self.selectedDate
            notifySubscriber()
        case .month:
            lastCurrentMonth = self.currentMonth
        case .year:
            lastCurrentMonth = self.currentMonth
        }
    }
    
    func notifySubscriber() {
        if configuration.allowMultipleSelection {
            guard let selectedDates else { return }
            onMultipleDateSelection.send(selectedDates)
        } else if configuration.allowRangeSelection {
            guard let startDate, let endDate else { return }
            onDateRangeSelection.send((startDate, endDate))
        } else {
            guard let selectedDate else { return }
            onSingleDateSelection.send(selectedDate)
        }
    }
    
}
