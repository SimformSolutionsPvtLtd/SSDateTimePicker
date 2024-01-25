//
//  SSCalendarManager.swift
//  DateTimePicker
//
//  Created by Rizwana Desai on 27/11/23.
//

import Foundation
import SwiftUI
import Combine

/// A manager class for handling the state and behavior of the SSDatePicker.
final class SSDatePickerManager: ObservableObject, DatePickerConfigurationDirectAccess {
    
    // MARK: - Properties
    
    /// The current month displayed in the date picker.
    /// Setting this property will determine the month whose calendar dates will be displayed when the picker is opened.
    @Published var currentMonth: Date
    
    /// The selected date in the date picker. Set this property to pre-select a specific date.
    @Published var selectedDate: Date? = nil
    
    /// The selected dates in the date picker when multiple selection is allowed. Set this property to pre-select a specific dates.
    @Published var selectedDates: [Date]? = nil
    
    /// The start date for range selection in the date picker.
    @Published var startDate: Date? = nil
    
    /// The end date for range selection in the date picker.
    @Published var endDate: Date? = nil
    
    /// List of dates that needs to be disabled
    var disableDates: [Date]?
    
    /// The configuration for the SSDatePicker.
    public var configuration: SSDatePickerConfiguration
    
    /// The year range displayed in the year selection view.
    @Published private(set) var yearRange = [Int]()
    
    /// The last known current month for canceling selection.
    private var lastCurrentMonth: Date
    
    /// The last known selected date for canceling selection.
    private var lastSelectedDate: Date?
    
    var dateRangeSelectionCallback: (DateRange) -> () = {_ in}
    var multiDateSelectionCallback: ([Date]) -> () = {_ in}
    var dateSelectionCallback: (Date) -> () = {_ in}
    
    // MARK: - Initializer
    
    /// Initializes the SSDatePickerManager with the provided configuration.
    ///
    /// - Parameters:
    ///   - currentMonth: The initial current month to be displayed in the date picker.
    ///   - selectedDate: The initially selected date to be displayed in the date picker.
    ///   - configuration: The style configuration for the SSDatePicker.
    init(currentMonth: Date = Date(), selectedDate: Date? = nil, configuration: SSDatePickerConfiguration = SSDatePickerConfiguration()) {
        self.currentMonth = currentMonth
        self.selectedDate = selectedDate
        self.configuration = configuration
        self.lastCurrentMonth = currentMonth
        self.lastSelectedDate = selectedDate
    }
    
    // MARK: - Methods
    
    /// Advances to the next month, year based on the current view (date, month, or year).
    func actionNext(for view: SelectionView) {
        switch view {
        case .date:
            currentMonth = currentMonth.getNextMonth(calendar) ?? currentMonth
        case .month:
            currentMonth = currentMonth.getNextYear(calendar) ?? currentMonth
        case .year:
            guard let year = self.yearRange.last else { return }
            self.updateYearRange(year: year+12)
        }
    }
    
    /// Moves back to the previous month, year based on the current view (date, month, or year).
    func actionPrev(for view: SelectionView) {
        switch view {
        case .date:
            currentMonth = currentMonth.getPreviousMonth(calendar) ?? currentMonth
        case .month:
            currentMonth = currentMonth.getPreviousYear(calendar) ?? currentMonth
        case .year:
            guard let year = self.yearRange.first else { return }
            self.updateYearRange(year: year-1)
        }
    }
    
    /// Checks if a given month is currently selected in the date picker.
    func isSelected(_ month: String) -> Bool {
        month.lowercased() == (selectedDate ?? currentMonth).fullMonth.lowercased()
    }
    
    /// Checks if a given year is currently selected in the date picker.
    func isSelected(_ year: Int) -> Bool {
        year == (selectedDate ?? currentMonth).year(calendar)
    }
    
    /// Updates the date selection based on the chosen date.
    func updateDateSelection(date: Date) {
        if configuration.allowMultipleSelection {
            if selectedDates == nil  {
                self.selectedDates = []
            }
            updateMultipleSelection(date: date)
        } else if configuration.allowRangeSelection {
            self.updateRangeSelection(date: date)
        } else {
            self.selectedDate = date
        }
    }
    
    func updateMultipleSelection(date: Date) {
        // Find the index of the selected date in the array, if it exists
        if let existingIndex = selectedDates?.firstIndex(where: { selectedDate in
            calendar.isDate(date, equalTo: selectedDate, toGranularities: [.day, .month, .year])
        }) {
            // If the date is already selected, remove it to support deselection
            selectedDates?.remove(at: existingIndex)
        } else {
            // If the date is not selected, add it to the selected dates array
            selectedDates?.append(date)
        }
    }
    
    func handleMultiDateDeselection(date: Date) {
        
    }
    
    /// Updates the range selection based on the chosen date.
    func updateRangeSelection(date: Date) {
        if let startDate = startDate , date >= configuration.calendar.startOfDay(for: startDate) {
            endDate = date
        } else {
            startDate = date
        }
    }
    
    /// Updates the month selection based on the chosen month.
    func updateMonthSelection(month: Int) {
        guard let selectedDate else {
            var component = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self.currentMonth)
            component.month = month
            self.currentMonth = calendar.date(from: component) ?? currentMonth
            return
        }
        var component = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: selectedDate)
        component.month = month
        self.selectedDate = calendar.date(from: component)
        self.currentMonth = self.selectedDate ?? currentMonth
    }
    
    /// Updates the year selection based on the chosen year.
    func updateYearSelection(year: Int) {
        guard let selectedDate else {
            var component = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self.currentMonth)
            component.year = year
            self.currentMonth = calendar.date(from: component) ?? currentMonth
            return
        }
        var component = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: selectedDate)
        component.year = year
        self.selectedDate = calendar.date(from: component)
        self.currentMonth = self.selectedDate ?? currentMonth
    }
    
    /// Updates the displayed year range in the year selection view.
    func updateYearRange(year: Int) {
        let lowerBound = year - 11
        let upperBound = year
        self.yearRange = Array(lowerBound...upperBound)
    }
    
    /// Reverts the selection to the last known values before the user's interaction.
    ///
    /// - Parameter view: The view (date, month, or year) for which the selection is being canceled.
    func selectionCanceled(for view: SelectionView) {
        switch view {
        case .date:
            self.selectedDate = lastSelectedDate
        case .month, .year:
            self.currentMonth = lastCurrentMonth
        }
    }
    
    /// Confirms the selection and notifies the delegate.
    ///
    /// - Parameter view: The view (date, month, or year) for which the selection is being confirmed.
    func selectionConfirmed(for view: SelectionView) {
        switch view {
        case .date:
            lastSelectedDate = self.selectedDate
            handleCallback()
        case .month, .year:
            lastCurrentMonth = self.currentMonth
        }
    }
    
    /// Notifies the delegate about the selected dates based on the configuration.
    func handleCallback() {
        if configuration.allowMultipleSelection {
            guard let selectedDates else { return }
            multiDateSelectionCallback(selectedDates)
        } else if configuration.allowRangeSelection {
            guard let startDate, let endDate else { return }
            dateRangeSelectionCallback(DateRange(startDate, endDate))
        } else {
            guard let selectedDate else { return }
            dateSelectionCallback(selectedDate)
        }
    }
    
    /// Determines if a given date can be selected based on a list of disabled dates.
    /// - Parameters:
    ///   - date: The date to be checked for selectability.
    /// - Returns: `true` if the date is selectable, `false` if it is disabled.
    func canSelectDate(_ date: Date) -> Bool {
        guard let disableDates = disableDates else {
            return true // all dates are selectable if disableDates is nil
        }
        
        return !disableDates.contains { disableDate in
            calendar.isDate(date, equalTo: disableDate, toGranularities: [.day, .month, .year])
        }
    }
    
}
