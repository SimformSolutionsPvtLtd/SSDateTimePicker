//
//  PickerViewModel.swift
//  Example
//
//  Created by Rizwana Desai on 01/12/23.
//

import Foundation
import DateTimePicker
import Combine

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
    
    //MARK: - init

    init() {
        self.datePickerManager = SSDatePickerManager(currentMonth: Date())
        self.timePickerManager = SSTimePickerManager(configuration: SSTimePickerConfiguration())
        subscribeForEvents()
    }
    
    //MARK: - Methods

    //MARK: Attaches a subscriber's to observe selected values
    func subscribeForEvents() {
        onSingleDateSelection()
        onMultipleDateSelection()
        onDateRangeSelection()
        onTimeSelection()
    }
    
    func onTimeSelection() {
        self.timePickerManager.onTimeSelection.sink { [weak self] selectedTime in
            print("onTimeSelection:: \(String(describing: selectedTime))")
            self?.selectedTime = selectedTime
        }.store(in: &cancellable)
    }
    
    func onSingleDateSelection() {
        self.datePickerManager.onSingleDateSelection.sink { [weak self] date in
            print("onSingleDateSelection:: \(date)")
            self?.selectedDate = date
        }.store(in: &cancellable)
    }
    
    func onMultipleDateSelection() {
        self.datePickerManager.onMultipleDateSelection.sink { [weak self] dates in
            print("onMultipleDateSelection:: \(dates)")
            self?.selectedDates = dates
        }.store(in: &cancellable)
    }
    
    func onDateRangeSelection() {
        self.datePickerManager.onDateRangeSelection.sink { [weak self] (startDate, endDate) in
            print("onDateRangeSelection:: \(startDate) - \(endDate)")
            self?.startDate = startDate
            self?.endDate = endDate
        }.store(in: &cancellable)
    }
    
    //MARK: Date picker configuration methods
    
    func configureForMultipleDateSelection() {
        var configuration = SSDatePickerConfiguration()
        configuration.allowMultipleSelection = true
//        configuration.minimumDate = Calendar.current.date(byAdding: .day, value: -10, to: Date())!
//        configuration.maximumDate = Calendar.current.date(byAdding: .day, value: 5, to: Date())!
        resetSelection()
        datePickerManager.configuration = configuration
    }
    
    func configureForSingleDateSelection() {
        var configuration = SSDatePickerConfiguration()
//        configuration.disablePastDates = true
        //        resetSelection()
//        configuration.headerDateFormat = DateFormat.fullDate
        datePickerManager.configuration = configuration
    }
    
    func configureForDateRangeSelection() {
        var configuration = SSDatePickerConfiguration()
        configuration.allowRangeSelection = true
//        resetSelection()
        datePickerManager.configuration = configuration
    }
    
    func resetSelection() {
        datePickerManager.selectedDates = nil
        datePickerManager.selectedDate = nil
        datePickerManager.startDate = nil
        datePickerManager.endDate = nil
    }
}
