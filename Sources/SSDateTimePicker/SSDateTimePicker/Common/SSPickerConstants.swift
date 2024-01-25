//
//  SSCalendarConstant.swift
//  DateTimePicker
//
//  Created by Rizwana Desai on 23/11/23.
//

import Foundation
import UIKit
import SwiftUI

let screen = UIScreen.main.bounds

// MARK: - Picker Constants

struct SSPickerConstants {
    
    static let pickerViewWidth: CGFloat = screen.width - (pickerLeadingTrailing*2)
    static let pickerViewInnerPadding: CGFloat = 8
    static let pickerLeadingTrailing: CGFloat = 40
    static let bottomButtonHSpacing: CGFloat = 5
    static let widthForDaysOfWeek: CGFloat =  (pickerViewWidth - (pickerViewInnerPadding*2)) / 7
    static let monthYearGridSpacing: CGFloat = 15
    static let horizontalSpacingDates: CGFloat = 0
    static let verticleSpacingDates: CGFloat = 0
    static let selectionCirclePadding: CGFloat = 5
    static let dateRangeSelectionCornerRadius: CGFloat = 11
    static let monthYearViewTopSpace: CGFloat = 20
    static let monthYearViewBottomSpace: CGFloat = 20
    static let verticleSpacingTen: CGFloat = 10
    static let paddingTen: CGFloat = 10
    static let paddingFive: CGFloat = 5
    static let monthYearGridRows: Int = 3
    static let rangeSelectionPadding: CGFloat = 2
    static let deviderBottomPadding: CGFloat = 8
    
    // Time picker constant
    
    static let timeFieldPadding: CGFloat = 8
    static let timeFieldCornerRadius: CGFloat = 8
    static let circleSize: CGFloat = 40
    static let clockPadding: CGFloat = 50
    static let clockHeight: CGFloat = 300
    static let clockNumberRotationDegree: CGFloat = 30 // To create clock on 360 degree angle, use 30 degree (12*30 = 360)
    static let minuteRotationDegree: CGFloat = 6 // 12*5*6 = 360

}

// MARK: - Font Size

struct Size {
    static let headerTitle: CGFloat = 12
    static let headerDate: CGFloat = 20
    static let month: CGFloat = 14
    static let year: CGFloat = 14
    static let buttonsText: CGFloat = 15
    static let currentMonthYear: CGFloat = 14
    static let clockNumber: CGFloat = 15
    static let timeLabel: CGFloat = 20
    static let timeFormat: CGFloat = 12
    static let selectedTimeFormat: CGFloat = 15
}

// MARK: - DateFormat

/// A struct containing commonly used date format strings for formatting and parsing dates.
public struct DateFormat {
    
    /// Abbreviated month format (e.g., "Dec").
    public static let abbreviatedMonth = "MMM"
    
    /// Day of the week with month and day format (e.g., "Friday December 3").
    public static let dayOfWeekWithMonthAndDay = "EEEE MMMM d"
    
    /// Full month format (e.g., "December").
    public static let fullMonth = "MMMM"
    
    /// Month and year format (e.g., "December, 2023").
    public static let monthYear = "MMMM, yyyy"
    
    /// Month, day, and year format (e.g., "Jun 3, 2023").
    public static let monthDateYear = "MMM d, yyyy"
    
    /// Day, month, and year format (e.g., "3 Jun, 2023").
    public static let dateMonthYear = "d MMM, yyyy"
    
    /// Full date with day, month, and year format (e.g., "03 December, 2023").
    public static let dateMonthYearFull = "dd MMMM, yyyy"
    
    /// Month, day, and year full format (e.g., "December 03, 2023").
    public static let monthDateYearFull = "MMMM dd, yyyy"
    
    /// Year, month, and day format (e.g., "2023-06-03").
    public static let yearMonthDate = "yyyy-MM-dd"
    
    /// Short month and year format (e.g., "Jun 2023").
    public static let shortMonthYear = "MMM yyyy"
    
    /// Day of the week, day, month, and year format (e.g., "Monday, 3 Jun, 2023").
    public static let dayMonthYear = "EEEE, d MMM, yyyy"
    
    /// Full date format (e.g., "Monday, Jun 03, 2023").
    public static let fullDate = "EEEE, MMMM d, yyyy"
    
    /// Time-only format with padding (e.g., "12:45 PM").
    public static let timeOnlyWithPadding = "hh:mm a"
    
    /// Twenty-four-hour time format (e.g., "12:45").
    public static let twentyFourHourFormat = "HH:mm"
    
}
