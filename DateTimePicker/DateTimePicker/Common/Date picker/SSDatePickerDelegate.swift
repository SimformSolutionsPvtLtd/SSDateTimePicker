//
//  SSDatePickerDelegate.swift
//  DateTimePicker
//
//  Created by Rizwana Desai on 08/12/23.
//

import Foundation

public protocol SSDatePickerDelegate: AnyObject {
    
    /// Notifies the delegate when a single date is selected.
    /// - Parameter selectedDate: The selected date.
    func datePicker(didSelectDate selectedDate: Date)
    
    /// If the date picker allows multiple date selection,  this method notifies the delegate when multiple dates are selected.
    /// - Parameter selectedDates: An array of selected dates.
    func datePicker(didSelectMultipleDates selectedDates: [Date])
    
    /// If the date picker allows range selection, this method is called when a start date and an end date are selected.
    /// - Parameters:
    ///   - selectedStartDate: The selected start date of the range.
    ///   - selectedEndDate: The selected end date of the range.
    func datePicker(didSelectStartDate selectedStartDate: Date, didSelectEndDate selectedEndDate: Date)

}

public extension SSDatePickerDelegate {
    
    func datePicker(didSelectDate date: Date) { }
    func datePicker(didSelectMultipleDates dates: [Date]) { }
    func datePicker(didSelectStartDate date: Date, didSelectEndDate: Date) { }

}
