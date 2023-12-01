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
    
    static let pickerViewWidth: CGFloat = screen.width - 40
    
    static let horizontalSpacing: CGFloat = 50
    
    static let widthForDaysOfWeek: CGFloat = (pickerViewWidth - (horizontalSpacing*2)) / 7
    
    static let monthYearGridSpacing: CGFloat = 15
    
}


enum SelectionView {
    case date
    case month
    case year
}
