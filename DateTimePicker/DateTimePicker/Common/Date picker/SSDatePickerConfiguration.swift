//
//  SSCalendarConfiguration.swift
//  DateTimePicker
//
//  Created by Rizwana Desai on 23/11/23.
//

import Foundation
import SwiftUI


public struct SSDatePickerConfiguration {
    
    // Colors
    public var headerTitleColor: Color = Color.gray
    public var headerDateColor: Color = Color.black
    public var weekdayTextColor: Color = Color.gray
    public var dateMonthYearTextColor: Color = Color.black
    public var selectionForegroundColor: Color = Color.white
    public var selectionBackgroundColor: Color
    public var todayColor: Color = Color.black
    public var todaySelectionColor: Color = Color.clear
    public var buttonsForegroundColor: Color
    public var pickerBackgroundColor: Color
    public var nextPrevButtonColor: Color = Color.black
    public var monthYearNavigationLabelColor: Color = Color.black
    public var popupOverlayColor: Color = Color.black.opacity(0.5)
   
    // Corner radius
    public var pickerViewRadius: CGFloat = 15
    
    // Configuration options for date selection.
    public var allowMultipleSelection: Bool = false
    public var allowRangeSelection: Bool = false
    public var minimumDate: Date?
    public var maximumDate: Date?
    public var disableFutureDates: Bool = false
    public var disablePastDates: Bool = false
    public var calendar: Calendar = Calendar.current

    // Date format
    public var headerDateFormat: String = DateFormat.monthDateYear
    
    public init(pickerBackgroundColor: Color, selectionColor: Color) {
        self.selectionBackgroundColor = selectionColor
        self.buttonsForegroundColor = selectionColor
        self.pickerBackgroundColor = pickerBackgroundColor
    }
    
    public init() {
        self.selectionBackgroundColor = .darkPink
        self.buttonsForegroundColor = .darkPink
        self.pickerBackgroundColor = .lightPink
    }
    
}

protocol DatePickerConfigurationDirectAccess {
    
    var configuration: SSDatePickerConfiguration { get }
    
}

extension DatePickerConfigurationDirectAccess {
    
    var calendar: Calendar {
        configuration.calendar
    }
    
    var headerTitleColor: Color {
        configuration.headerTitleColor
    }
    
    var headerDateColor: Color {
        configuration.headerDateColor
    }
    
    var weekdayTextColor: Color {
        configuration.weekdayTextColor
    }
    
    var dateMonthYearTextColor: Color {
        configuration.dateMonthYearTextColor
    }
    
    var selectionForegroundColor: Color {
        configuration.selectionForegroundColor
    }
    
    var selectionBackgroundColor: Color {
        configuration.selectionBackgroundColor
    }
    
    var todayColor: Color {
        configuration.todayColor
    }
    
    var todaySelectionColor: Color {
        configuration.todaySelectionColor
    }
    
    var buttonsForegroundColor: Color {
        configuration.buttonsForegroundColor
    }
    
    var pickerBackgroundColor: Color {
        configuration.pickerBackgroundColor
    }
    
    // date format
    var headerDateFormat: String {
        configuration.headerDateFormat
    }
    
    var pickerViewRadius: CGFloat {
        configuration.pickerViewRadius
    }
    
    var nextPrevButtonColor: Color {
        configuration.nextPrevButtonColor
    }
    
    var monthYearNavigationLabelColor: Color {
        configuration.monthYearNavigationLabelColor
    }
    
    var allowMultipleSelection: Bool {
        configuration.allowMultipleSelection
    }
    
    var allowRangeSelection: Bool {
        configuration.allowRangeSelection
    }
    
    var minimumDate: Date? {
        configuration.minimumDate
    }
    
    var maximumDate: Date? {
        configuration.maximumDate
    }
    
    var popupOverlayColor: Color {
        configuration.popupOverlayColor
    }
    
    var disablePastDates: Bool {
        configuration.disablePastDates
    }

    var disableFutureDates: Bool {
        configuration.disableFutureDates
    }

}
