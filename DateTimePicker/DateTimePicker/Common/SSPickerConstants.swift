//
//  SSCalendarConstant.swift
//  DateTimePicker
//
//  Created by Rizwana Desai on 23/11/23.
//

import Foundation
import UIKit

let screen = UIScreen.main.bounds

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

public struct DateFormat {
    
    public static let abbreviatedMonth = "MMM" // Dec
    public static let dayOfWeekWithMonthAndDay = "EEEE MMMM d" // Friday December 3
    public static let fullMonth = "MMMM" // December
    public static let monthYear = "MMMM, yyyy" // December, 2023
    public static let monthDateYear = "MMM d, yyyy" // Jun 3, 2023
    public static let dateMonthYear = "d MMM, yyyy" // 3 Jun, 2023
    public static let dateMonthYearFull = "dd MMMM, yyyy" // 03 December, 2023
    public static let monthDateYearFull = "MMMM dd, yyyy" // December 03, 2023
    public static let yearMonthDate = "yyyy-MM-dd" // 2023-06-03
    public static let shortMonthYear = "MMM yyyy" // Jun 2023
    public static let dayMonthYear = "EEEE, d MMM, yyyy" // Monday, 3 Jun, 2023
    public static let fullDate = "EEEE, MMMM d, yyyy" // Monday, Jun 03, 2023
    public static let timeOnlyWithPadding = "hh:mm a" // 12:45 PM
    public static let twentyFourHourFormat = "HH:mm"
}

public enum SelectionView {
    case date
    case month
    case year
}
