//
//  SSCalendarConstant.swift
//  DateTimePicker
//
//  Created by Rizwana Desai on 23/11/23.
//

import Foundation
import UIKit

let screen = UIScreen.main.bounds


struct SSCalendarConstants {
    
    static let pickerViewWidth: CGFloat = screen.width - (horizontalSpacing*2)
    static let pickerViewInnerPadding: CGFloat = 8

    static let horizontalSpacing: CGFloat = 40
    
    static let widthForDaysOfWeek: CGFloat =  (pickerViewWidth - (pickerViewInnerPadding*2)) / 7
    static let monthYearGridSpacing: CGFloat = 15
    
}


public enum SelectionView {
    case date
    case month
    case year
}
