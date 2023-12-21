//
//  SSDateRangePicker.swift
//  SSDateTimePicker
//
//  Created by Rizwana Desai on 18/12/23.
//

import SwiftUI

public struct SSDateRangePicker: View {
    
    // MARK: - Properties

    var datePicker: SSDatePicker
    
    // MARK: - Initializer

    init(_ datePicker: SSDatePicker) {
        self.datePicker = datePicker
    }
    
    //MARK: - Body

    public var body: some View {
        datePicker
    }
    
}

// MARK: - Modifiers

extension SSDateRangePicker {
    
    /// Sets a callback closure to be executed when a date range is selected.
    ///
    /// - Parameter completion: A closure to be called when a date range is selected. The closure takes a `DateRange` parameter.
    /// - Returns: The modified `SSDateRangePicker` instance.
    public func onDateRangeSelection(_ completion: @escaping (DateRange) -> ()) -> SSDateRangePicker {
        let picker = self
        picker.datePicker.datePickerManager.dateRangeSelectionCallback = completion
        return picker
    }
    
    /// Sets the selected dates for the date range picker.
    ///
    /// - Parameter dateRange: An optional `DateRange` representing the selected date range. Pass `nil` to clear the selection.
    /// - Returns: The modified `SSDateRangePicker` instance.
    public func selectedDateRange(_ dateRange: DateRange?) -> SSDateRangePicker {
        let picker = self
        picker.datePicker.datePickerManager.startDate = dateRange?.startDate
        picker.datePicker.datePickerManager.endDate = dateRange?.endDate
        return picker
    }
}

