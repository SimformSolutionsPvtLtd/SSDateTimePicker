//
//  SSCalendarConfiguration.swift
//  DateTimePicker
//
//  Created by Rizwana Desai on 23/11/23.
//

import Foundation
import SwiftUI

/// A configuration structure for customizing the appearance and behavior of the SSDatePicker.
struct SSDatePickerConfiguration {
    
    // MARK: - Colors and fonts
    
    /// Color and font for the header title ("Select date").
    var headerTitleStyle: SSStyle = .init(font: .headerTitle, color: .gray)
    
    /// Color  and font for the header date text.
    var headerDateStyle: SSStyle = .init(font: .headerDate, color: .black)
    
    /// Text color  and font for weekdays in the picker.
    var weekdayStyle: SSStyle = .init(font: .weekday, color: .gray)
    
    /// Text color and font for date in the picker.
    var dateStyle: SSStyle = .init(font: .date, color: .black)
    
    /// Text color and font for month text.
    var monthStyle: SSStyle = .init(font: .month, color: .black)
    
    /// Text color and  font for selected month text.
    var selectedMonthStyle: SSStyle = .init(font: .selectedMonth, color: .darkPink)
    
    /// Text color and font for year text.
    var yearStyle: SSStyle = .init(font: .year, color: .black)
    
    /// Text color and font for selected year text.
    var selectedYearStyle: SSStyle = .init(font: .selectedYear, color: .darkPink)
    
    /// Font and foreground color for buttons.
    var buttonStyle: SSStyle = .init(font: .buttonText, color: .darkPink)
    
    /// Font and color for the current month and year label at the bottom of the picker.
    var currentMonthYearLabelStyle: SSStyle = .init(font: .currentMonthYear, color: .black)
    
    /// Selected date foreground and background color.
    var selectedDateColor: SSColor = .init(foregroundColor: .white, backgroundColor: .darkPink)
    
    /// Foreground and background color for today's date text.
    var todayDateColor: SSColor = .init(foregroundColor: nil, backgroundColor: nil)
    
    /// Background and foreground color for today's selected date.
    var todayDateSelectionColor: SSColor = .init(foregroundColor: nil, backgroundColor: nil)
    
    /// Background color for the picker.
    var pickerBackgroundColor: Color
    
    /// Color for the separator lines.
    var sepratorLineColor: Color = Color(uiColor: UIColor.opaqueSeparator)
    
    /// Color for the overlay background of the popup.
    var popupOverlayColor: Color = Color.black.opacity(0.5)
    
    // MARK: - Date Selection Behavior Configuration Properties
    
    /// Allow selecting multiple dates.
    var allowMultipleSelection: Bool = false
    
    /// Allow selecting a range of dates.
    var allowRangeSelection: Bool = false
    
    /// The minimum selectable date. Dates before this minimum date will be disabled for selection.
    var minimumDate: Date?
    
    /// The maximum selectable date. Dates after this maximum date will be disabled for selection.
    var maximumDate: Date?
    
    /// Calendar to use for date calculations.
    var calendar: Calendar = Calendar.current
    
    // MARK: - Additional Properties
    
    /// Radius for the corner of the picker view.
    var pickerViewRadius: CGFloat = 15
    
    /// Date format for the header.
    var headerDateFormat: String = DateFormat.monthDateYear
    
    // MARK: - Initializer
    
    /// Creates a custom-themed date picker configuration.
    ///
    /// - Parameters:
    ///   - pickerBackgroundColor: The background color of the picker view. Default is light pink.
    ///   - primaryColor: The color for both the selected date's background and the buttons. Deafult is dark pink.
    ///
    /// Use this instance to set up the appearance and behavior of the SSDatePicker according to your preferences.
    init(pickerBackgroundColor: Color = Color.lightPink, primaryColor: Color = Color.darkPink) {
        self.selectedDateColor.backgroundColor = primaryColor
        self.buttonStyle.color = primaryColor
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
        configuration.headerTitleStyle.color
    }
    
    var headerDateColor: Color {
        configuration.headerDateStyle.color
    }
    
    var weekdayTextColor: Color {
        configuration.weekdayStyle.color
    }
    
    var dateMonthYearTextColor: Color {
        configuration.dateStyle.color
    }
    
    var selectedDateTextColor: Color {
        configuration.selectedDateColor.foregroundColor ?? dateMonthYearTextColor
    }
    
    var selectionBackgroundColor: Color {
        configuration.selectedDateColor.backgroundColor ?? .darkPink
    }
    
    var todayColor: Color {
        configuration.todayDateColor.foregroundColor ?? dateMonthYearTextColor
    }
    
    var todaySelectionBgColor: Color {
        configuration.todayDateSelectionColor.backgroundColor ?? selectionBackgroundColor
    }
    
    var todaySelectionFontColor: Color {
        configuration.todayDateSelectionColor.foregroundColor ?? dateMonthYearTextColor
    }
    
    var buttonsForegroundColor: Color {
        configuration.buttonStyle.color
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
        configuration.buttonStyle.color
    }
    
    var monthYearNavigationLabelColor: Color {
        configuration.currentMonthYearLabelStyle.color
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
       
    var headerTitleFont: Font {
        configuration.headerTitleStyle.font
    }
    
    var headerDateFont: Font {
        configuration.headerDateStyle.font
    }
    
    var weekdayTextFont: Font {
        configuration.weekdayStyle.font
    }
    
    var dateTextFont: Font {
        configuration.dateStyle.font
    }
    
    var monthTextFont: Font {
        configuration.monthStyle.font
    }
    
    var selectedMonthTextFont: Font {
        configuration.selectedMonthStyle.font
    }
    
    var yearTextFont: Font {
        configuration.yearStyle.font
    }
    
    var buttonsFont: Font {
        configuration.buttonStyle.font
    }
    
    var currentMonthYearBottomLabelFont: Font {
        configuration.currentMonthYearLabelStyle.font
    }
    
    var selectedYearTextFont: Font {
        configuration.selectedYearStyle.font
    }
    
    var sepratorLineColor: Color {
        configuration.sepratorLineColor
    }
    
}
