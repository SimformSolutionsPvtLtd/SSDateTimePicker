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
    static let selectionCirclePadding: CGFloat = 5
    static let dateRangeSelectionCornerRadius: CGFloat = 11
    static let monthYearViewTopSpace: CGFloat = 20
    static let monthYearViewBottomSpace: CGFloat = 20
    static let verticleSpacingTen: CGFloat = 10
    static let paddingTen: CGFloat = 10
    static let paddingFive: CGFloat = 5

    static let monthYearGridRows: Int = 3
}

public enum SelectionView {
    case date
    case month
    case year
}
