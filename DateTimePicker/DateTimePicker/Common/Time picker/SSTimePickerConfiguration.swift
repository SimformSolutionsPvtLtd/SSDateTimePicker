//
//  SSTimePickerConfiguration.swift
//  DateTimePicker
//
//  Created by Rizwana Desai on 04/12/23.
//

import Foundation
import SwiftUI

public struct SSTimePickerConfiguration {
    
    // MARK: - Colors

    /** Background color for Hour (HH) and Minute (MM) labels. */
    public var timeLabelBackgroundColor: Color
    /** Font color for Hour (HH) and Minute (MM) labels. */
    public var timeLabelForegroundColor: Color
    /** Color to highlight the selected time format (AM/PM). */
    public var timeFormatSelectionColor: Color
    /** Default color for the AM/PM time format when deselected. */
    public var timeFormatColor: Color = Color.gray
    /** Color for the header title "Select Time". */
    public var headerTitleCoor: Color = Color.gray
    /** Text color for the selected number on the clock. */
    public var clockSelectedNumberTextColor: Color = Color.white
    /** Color for the clock hand and circular selection circle. */
    public var clockHandColor: Color
    public var clockNumberTextColor: Color = Color.black
    public var popupOverlayColor: Color = Color.black.opacity(0.5)
    public var buttonsForegroundColor: Color
    public var pickerBackgroundColor: Color

    // MARK: - Font properties

    public var headerTitleFont: Font = .system(size: 12, weight: .bold)
    /** Font for Hour (HH) and Minute (MM) labels. */
    public var timeLabelFont: Font = .system(size: 20, weight: .semibold)
    /** Font for the AM/PM time format when deselected. */
    public var timeFormatFont: Font = .system(size: 12, weight: .bold)
    /** Font for the AM/PM time format when selected. */
    public var selectedTimeFormatFont: Font = .system(size: 15, weight: .bold)
    public var clockNumberFont: Font = .system(size: 15)
    public var buttonFont: Font = .system(size: 15, weight: .semibold)

    // MARK: - Additional Properties

    public var pickerViewRadius: CGFloat = 15
    
    // MARK: - Initializer

    /// Creates a custom-themed time picker.
    ///
    /// - Parameters:
    ///   - pickerBackgroundColor: The color for the background of the picker view. Default is light pink.
    ///   - primaryColor: This parameter determines the color for the `selected time formate(AM/PM), buttons text color, time                      Text(HH:MM) and clock hand color.`
    ///   - timeLabelBackgroundColor: The color for the background of the time label(HH:MM). Default is light pink.
    /// Use this instance to set up the appearance of the SSTimePicker according to your prefrence.
    public init(pickerBackgroundColor: Color = Color.lightPink, primaryColor: Color = Color.darkPink, timeLabelBackgroundColor: Color = Color.peach) {
        self.timeLabelForegroundColor = primaryColor
        self.timeFormatSelectionColor = primaryColor
        self.buttonsForegroundColor = primaryColor
        self.clockHandColor = primaryColor
        self.pickerBackgroundColor = pickerBackgroundColor
        self.timeLabelBackgroundColor = timeLabelBackgroundColor
    }

}

protocol TimePickerConfigurationDirectAccess {
    
    var configuration: SSTimePickerConfiguration { get }
    
}

extension TimePickerConfigurationDirectAccess {
    
    var timeLabelBackgroundColor: Color {
        configuration.timeLabelBackgroundColor
    }
    
    var timeLabelForegroundColor: Color {
        configuration.timeLabelForegroundColor
    }
    
    var timeFormatSelectionColor: Color {
        configuration.timeFormatSelectionColor
    }
    
    var timeFormatColor: Color {
        configuration.timeFormatColor
    }
    
    var headerTitleCoor: Color {
        configuration.headerTitleCoor
    }
    
    var buttonsForegroundColor: Color {
        configuration.buttonsForegroundColor
    }
    
    var pickerBackgroundColor: Color {
        configuration.pickerBackgroundColor
    }
    
    var timeSelectionForegroundColor: Color {
        configuration.clockSelectedNumberTextColor
    }
    
    var popupOverlayColor: Color {
        configuration.popupOverlayColor
    }
    
    var pickerViewRadius: CGFloat {
        configuration.pickerViewRadius
    }
    
    var clockHandColor: Color {
        configuration.clockHandColor
    }
    
    var clockNumberTextColor: Color {
        configuration.clockNumberTextColor
    }
    
    var headerTitleFont: Font {
        configuration.headerTitleFont
    }
    
    var timeLabelFont: Font {
        configuration.timeLabelFont
    }
    
    var timeFormatFont: Font {
        configuration.timeFormatFont
    }
    
    var selectedTimeFormatFont: Font {
        configuration.selectedTimeFormatFont
    }
    
    var clockNumberFont: Font {
        configuration.clockNumberFont
    }
    
    var buttonFont: Font {
        configuration.buttonFont
    }
        
}
