//
//  SSCalendarConfiguration.swift
//  DateTimePicker
//
//  Created by Rizwana Desai on 23/11/23.
//

import Foundation
import SwiftUI

/// A configuration structure for customizing the appearance and behavior of the SSDatePicker.
public struct SSDatePickerConfiguration {
    
    // MARK: - Colors

    /** Color for the header title -"Select date". */
    public var headerTitleColor: Color = Color.gray
    /** Color for the header date text. */
    public var headerDateColor: Color = Color.black
    public var weekdayTextColor: Color = Color.gray
    /** list of Date, month, and year's text color in  picker. */
    public var dateMonthYearTextColor: Color = Color.black
    /** Selected date font color */
    public var selectedDateTextColor: Color = Color.white
    public var selectionBackgroundColor: Color
    public var todayColor: Color = Color.black
    public var todaySelectionBgColor: Color?
    public var buttonsForegroundColor: Color
    public var pickerBackgroundColor: Color
    public var nextPrevButtonColor: Color = Color.black
    /** Color for the text of navigation labels, such as "June, 2023" or "2023". */
    public var navigationLabelColor: Color = Color.black
    public var popupOverlayColor: Color = Color.black.opacity(0.5)
   
    // MARK: - Date selection behavior configuration properties

    public var allowMultipleSelection: Bool = false
    public var allowRangeSelection: Bool = false
    public var minimumDate: Date?
    public var maximumDate: Date?
    public var disableFutureDates: Bool = false
    public var disablePastDates: Bool = false
    public var calendar: Calendar = Calendar.current

    // MARK: - Font properties

    /** Color for the header title -"Select date". */
    public var headerTitleFont: Font = .system(size: 12, weight: .bold)
    /** Font for the header date text. */
    public var headerDateFont: Font = .system(size: 20, weight: .semibold)
    public var weekdayTextFont: Font = .caption
    public var dateTextFont: Font = .footnote
    public var monthTextFont: Font = .system(size: 14, weight: .regular)
    public var selectedMonthTextFont: Font = .system(size: 14, weight: .bold)
    public var yearTextFont: Font = .system(size: 14, weight: .regular)
    public var selectedYearTextFont: Font = .system(size: 14, weight: .bold)
    public var buttonsFont: Font = .system(size: 15, weight: .semibold)
    public var currentMonthYearBottomLabelFont: Font = .system(size: 14, weight: .medium)
    
    // MARK: - Additional Properties
  
    public var pickerViewRadius: CGFloat = 15
    public var headerDateFormat: String = DateFormat.monthDateYear
    
    // MARK: - Initializer

    /// Creates a custom-themed date picker.
    ///
    /// - Parameters:
    ///   - pickerBackgroundColor: The color for the background of the picker view. Default is light pink.
    ///   - primaryColor: This parameter determines the color for both the selected date's background and the buttons in the date picker.
    ///
    /// Use this instance to set up the appearance and behavior of the SSDatePicker according to your prefrence.
    public init(pickerBackgroundColor: Color = Color.lightPink, primaryColor: Color = Color.darkPink) {
        self.selectionBackgroundColor = primaryColor
        self.buttonsForegroundColor = primaryColor
        self.pickerBackgroundColor = pickerBackgroundColor
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
    
    var selectedDateTextColor: Color {
        configuration.selectedDateTextColor
    }
    
    var selectionBackgroundColor: Color {
        configuration.selectionBackgroundColor
    }
    
    var todayColor: Color {
        configuration.todayColor
    }
    
    var todaySelectionBgColor: Color? {
        configuration.todaySelectionBgColor
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
        configuration.navigationLabelColor
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
    
    var headerTitleFont: Font {
        configuration.headerTitleFont
    }
    
    var headerDateFont: Font {
        configuration.headerDateFont
    }
    
    var weekdayTextFont: Font {
        configuration.weekdayTextFont
    }
    
    var dateTextFont: Font {
        configuration.dateTextFont
    }
    
    var monthTextFont: Font {
        configuration.monthTextFont
    }
    
    var selectedMonthTextFont: Font {
        configuration.selectedMonthTextFont
    }
    
    var yearTextFont: Font {
        configuration.yearTextFont
    }
    
    var buttonsFont: Font {
        configuration.buttonsFont
    }
    
    var currentMonthYearBottomLabelFont: Font {
        configuration.currentMonthYearBottomLabelFont
    }
    
    var selectedYearTextFont: Font {
        configuration.selectedYearTextFont
    }

}
