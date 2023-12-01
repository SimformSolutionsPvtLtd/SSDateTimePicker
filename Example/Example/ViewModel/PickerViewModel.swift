//
//  PickerViewModel.swift
//  Example
//
//  Created by Rizwana Desai on 01/12/23.
//

import Foundation
import DateTimePicker
import Combine

class PickerViewModel: ObservableObject {
    
    //MARK: - Property
    
    @Published var calendarManager: SSCalendarManager!
    @Published var selectedDate: Date?
    @Published var selectedDates: [Date]?
    @Published var startDate: Date?
    @Published var endDate: Date?
    var cancellable = Set<AnyCancellable>()
    
    init() {
        self.calendarManager = SSCalendarManager(currentMonth: Date())
        subscribeForEvents()
    }
    
    //MARK: - Methods

    //MARK: Attaches a subscriber's to observe selected values
    func subscribeForEvents() {
        onSingleDateSelection()
        onMultipleDateSelection()
        onDateRangeSelection()
    }
    
    func onSingleDateSelection() {
        self.calendarManager.onSingleDateSelection.sink { [weak self] date in
            print("onSingleDateSelection:: \(date)")
            self?.selectedDate = date
        }.store(in: &cancellable)
    }
    
    func onMultipleDateSelection() {
        self.calendarManager.onMultipleDateSelection.sink { [weak self] dates in
            print("onMultipleDateSelection:: \(dates)")
            self?.selectedDates = dates
        }.store(in: &cancellable)
    }
    
    func onDateRangeSelection() {
        self.calendarManager.onDateRangeSelection.sink { [weak self] (startDate, endDate) in
            print("onDateRangeSelection:: \(startDate) - \(endDate)")
            self?.startDate = startDate
            self?.endDate = endDate
        }.store(in: &cancellable)
    }
    
    //MARK: Date picker configuration methods
    
    func configureForMultipleDateSelection() {
        var configuration = SSCalendarConfiguration()
        configuration.allowMultipleSelection = true
//        configuration.minimumDate = Calendar.current.date(byAdding: .day, value: -10, to: Date())!
//        configuration.maximumDate = Calendar.current.date(byAdding: .day, value: 5, to: Date())!
        resetSelection()
        calendarManager.configuration = configuration
    }
    
    func configureForSingleDateSelection() {
        let configuration = SSCalendarConfiguration()
        //        resetSelection()
        calendarManager.configuration = configuration
    }
    
    func configureForDateRangeSelection() {
        var configuration = SSCalendarConfiguration()
        configuration.allowRangeSelection = true
        resetSelection()
        calendarManager.configuration = configuration
    }
    
    func resetSelection() {
        calendarManager.selectedDates = nil
        calendarManager.selectedDate = nil
        calendarManager.startDate = nil
        calendarManager.endDate = nil
    }
}
