//
//  SSMultiDatePicker.swift
//  SSDateTimePicker
//
//  Created by Rizwana Desai on 18/12/23.
//

import SwiftUI

public struct SSMultiDatePicker: View {
    
    // MARK: - Properties
    
    var datePicker: SSDatePicker
    
    //MARK: - Initializer
    
    init(_ datePicker: SSDatePicker) {
        self.datePicker = datePicker
    }
    
    //MARK: - Body
    
    public var body: some View {
        datePicker
    }
    
}

// MARK: - Modifiers

extension SSMultiDatePicker {
    
    /// Sets a callback closure to be executed when multiple dates are selected.
    ///
    /// - Parameter completion: A closure to be called when multiple dates are selected. The closure takes an array of `Date` as a parameter.
    /// - Returns: The modified `SSMultiDatePicker` instance.
    public func onMultiDateSelection(_ completion: @escaping ([Date]) -> ()) -> SSMultiDatePicker {
        let picker = self
        picker.datePicker.datePickerManager.multiDateSelectionCallback = completion
        return picker
    }
    
    /// Sets the selected dates for the multi-date picker.
    ///
    /// - Parameter dates: An optional array of `Date` representing the selected dates. Pass `nil` to clear the selection.
    /// - Returns: The modified `SSMultiDatePicker` instance.
    public func selectedDates(_ dates: [Date]?) -> SSMultiDatePicker {
        let picker = self
        picker.datePicker.datePickerManager.selectedDates = dates
        return picker
    }
}

