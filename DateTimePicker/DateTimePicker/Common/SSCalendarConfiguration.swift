//
//  SSCalendarConfiguration.swift
//  DateTimePicker
//
//  Created by Rizwana Desai on 23/11/23.
//

import Foundation
import SwiftUI


public struct SSCalendarConfiguration {
    
    // Colors
    var headerTitleColor: Color = Color.gray
    var headerDateColor: Color = Color.black
    var weekdayTextColor: Color = Color.gray
    var dateMonthYearTextColor: Color = Color.black
    var selectionForegroundColor: Color = Color.white
    var selectionBackgroundColor: Color
    var todayColor: Color = Color.black
    var todaySelectionColor: Color = Color.clear
    var buttonsForegroundColor: Color
    var pickerBackgroundColor: Color
    var nextPrevButtonColor: Color = Color.black
    var monthYearNavigationLabelColor: Color = Color.black
    
    // Date format
    var headerDateFormat: String = DateFormat.monthDateYear
    
    // Corner radius
    var pickerViewRadius: CGFloat = 15
    
    var calendar: Calendar = Calendar.current
    
    public init(pickerBackgroundColor: Color, selectionColor: Color) {
        self.selectionBackgroundColor = selectionColor
        self.buttonsForegroundColor = selectionColor
        self.pickerBackgroundColor = pickerBackgroundColor
    }
    
    public init() {
        self.selectionBackgroundColor = .darkGreen
        self.buttonsForegroundColor = .darkGreen
        self.pickerBackgroundColor = .lightGreen
    }
    
    
}


protocol ConfigurationDirectAccess {
    
    var configuration: SSCalendarConfiguration { get }
    
}

extension ConfigurationDirectAccess {
   
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
    
    var okBtnColor: Color {
        configuration.buttonsForegroundColor
    }

    var cancelBtnColor: Color {
        configuration.buttonsForegroundColor
    }
    
    var nextPrevButtonColor: Color {
        configuration.nextPrevButtonColor
    }
    
    var monthYearNavigationLabelColor: Color {
        configuration.monthYearNavigationLabelColor
    }
}
