//
//  PickerViewModel.swift
//  Example
//
//  Created by Rizwana Desai on 01/12/23.
//

import Foundation
import SSDateTimePicker
import Combine
import SwiftUI

final class PickerViewModel: ObservableObject {
    
    //MARK: - Property
    
    @Published var datePickerManager: SSDatePickerManager!
    @Published var timePickerManager: SSTimePickerManager!
    @Published var selectedDate: Date?
    @Published var selectedDates: [Date]?
    @Published var startDate: Date?
    @Published var endDate: Date?
    @Published var selectedTime: Date?
    var cancellable = Set<AnyCancellable>()
    
    //MARK: - Initializer
    
    init() {
        self.datePickerManager = SSDatePickerManager(currentMonth: Date())
        self.datePickerManager.delegate = self
        self.datePickerManager.datasource = self
        self.timePickerManager = SSTimePickerManager(configuration: SSTimePickerConfiguration())
        self.timePickerManager.delegate = self
    }
    
    //MARK: - Methods
    
    //MARK: Date picker configuration methods
    
    func configureForMultipleDateSelection() {
        datePickerManager = SSDatePickerManager(currentMonth: self.selectedDates?.first ?? Date())
        datePickerManager.delegate = self
        datePickerManager.datasource = self
        datePickerManager.selectedDates = self.selectedDates
        var configuration = SSDatePickerConfiguration()
        configuration.allowMultipleSelection = true
        datePickerManager.configuration = configuration
    }
    
    func configureForSingleDateSelection() {
        datePickerManager = SSDatePickerManager(currentMonth: self.selectedDate ?? Date())
        datePickerManager.delegate = self
        datePickerManager.datasource = self
        datePickerManager.selectedDate = self.selectedDate
    }
    
    func configureForDateRangeSelection() {
        datePickerManager = SSDatePickerManager(currentMonth: self.startDate ?? Date())
        datePickerManager.delegate = self
        datePickerManager.datasource = self
        datePickerManager.startDate = self.startDate
        datePickerManager.endDate = self.endDate
        var configuration = SSDatePickerConfiguration()
        configuration.allowRangeSelection = true
        datePickerManager.configuration = configuration
    }
    
    func customizedDatePicker() {
        self.datePickerManager = SSDatePickerManager(currentMonth: Date())
        self.datePickerManager.delegate = self
        var configuration = SSDatePickerConfiguration(pickerBackgroundColor: Color.themeBlack, primaryColor: Color.themeYellow)
        configuration.headerTitleColor = Color.white
        configuration.headerDateColor = Color.white
        configuration.weekdayTextColor = Color.white
        configuration.dateMonthYearTextColor = .white
        configuration.todayColor = Color.themeYellow
        configuration.navigationLabelColor = Color.white
        configuration.todaySelectionBgColor = Color.red
        configuration.todaySelectionFontColor = Color.white
        configuration.selectedDateTextColor = .black
        configuration.pickerViewRadius = 5
        configuration.headerDateFormat = DateFormat.fullDate
        configuration.sepratorLineColor = Color.white.opacity(0.7)
        datePickerManager.configuration = configuration
    }
    
    func getSelectedDates() -> String? {
        let dates = self.selectedDates?.compactMap({ date in
            date.monthDateYear
        }).joined(separator: ",")
        return dates
    }
    
}

// MARK: - SSTimePickerDelegate

extension PickerViewModel: SSTimePickerDelegate {
    
    func timePicker(didSelectTime selectedTime: Date) {
        self.selectedTime = selectedTime
    }
}

// MARK: - SSDatePickerDelegate & SSDatePickerDataSource

extension PickerViewModel: SSDatePickerDelegate, SSDatePickerDataSource {
    
    //MARK: Delegate Methods
    
    func datePicker(didSelectDate selectedDate: Date) {
        self.selectedDate = selectedDate
    }
    
    func datePicker(didSelectMultipleDates selectedDates: [Date]) {
        self.selectedDates = selectedDates
    }
    
    func datePicker(didSelectStartDate selectedStartDate: Date, didSelectEndDate selectedEndDate: Date) {
        self.startDate = selectedStartDate
        self.endDate = selectedEndDate
    }
    
    //MARK: Datasource method
    
    func datePicker(canSelectDate date: Date) -> Bool {
        guard !datePickerManager.configuration.allowRangeSelection else { return true }
        let day = Calendar.current.dateComponents([.day], from: date).day!
        return day != 4
    }
    
}
