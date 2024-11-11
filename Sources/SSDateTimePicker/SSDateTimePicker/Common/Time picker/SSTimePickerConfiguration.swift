//
//  SSTimePickerConfiguration.swift
//  DateTimePicker
//
//  Created by Rizwana Desai on 04/12/23.
//

import Foundation
import SwiftUI

/// A configuration structure for customizing the appearance and behavior of the SSTimePicker.
struct SSTimePickerConfiguration {
    
    // MARK: - Colors and fonts

    /// Color for the header title "Select Time".
    var headerTitleStyle: SSStyle = .init(font: Font.headerTitle, color: .gray)

    /// Text color for the selected and unselected number on the clock.
    var clockNumberStyle: SSStyle = .init(font: Font.clockNumber, color: .black)

    /// Font for Hour (HH) and Minute (MM) labels.
    var timeLabelStyle: SSStyle = .init(font: Font.timeLabel, color: .darkPink)
    
    /// Font for the AM/PM time format when unselected.
    var timeFormatStyle: SSStyle = .init(font: Font.timeFormat, color: .gray)
    
    /// Font for the AM/PM time format when selected.
    var selectedTimeFormatStyle: SSStyle = .init(font: Font.selectedTimeFormat, color: .darkPink)
    
    var buttonStyle: SSStyle = .init(font: Font.selectedTimeFormat, color: .darkPink)
    
    // MARK: - Colors
    
    /// Color for the clock hand and circular selection circle.
    var clockHandColor: Color
    
    /// Background and foreground color for Hour (HH) and Minute (MM) labels.
    var timeLabelBackgroundColor: Color = .peach
    
    /// Color for the overlay background of the popup.
    var popupOverlayColor: Color = Color.black.opacity(0.5)
        
    /// Background color for the picker.
    var pickerBackgroundColor: Color

    // MARK: - Additional Properties

    /// Radius for the corner of the picker view.
    var pickerViewRadius: CGFloat = 15
    
    // MARK: - Initializer

    /// Creates a custom-themed time picker configuration.
    ///
    /// - Parameters:
    ///   - pickerBackgroundColor: The background color of the picker view. Default is light pink.
    ///   - primaryColor: The color for the selected time format (AM/PM), buttons text color, time text (HH:MM), and clock hand color.
    ///   - timeLabelBackgroundColor: The background color for the time label (HH:MM). Default is light pink.
    ///
    /// Use this instance to set up the appearance and behavior of the SSTimePicker according to your preferences.
    init(pickerBackgroundColor: Color = Color.lightPink, primaryColor: Color = Color.darkPink, timeLabelBackgroundColor: Color = Color.peach) {
        self.timeLabelStyle.color = primaryColor
        self.selectedTimeFormatStyle.color = primaryColor
        self.buttonStyle.color = primaryColor
        self.clockHandColor = primaryColor
        self.pickerBackgroundColor = pickerBackgroundColor
        self.timeLabelBackgroundColor = timeLabelBackgroundColor
    }

}

/// A protocol providing direct access to specific properties of an `SSTimePickerConfiguration`.
protocol TimePickerConfigurationDirectAccess {
    
    var configuration: SSTimePickerConfiguration { get }
    
}

extension TimePickerConfigurationDirectAccess {
    
    var timeLabelBackgroundColor: Color {
        configuration.timeLabelBackgroundColor
    }
    
    var timeLabelForegroundColor: Color {
        configuration.timeLabelStyle.color
    }
    
    var timeFormatSelectionColor: Color {
        configuration.selectedTimeFormatStyle.color
    }
    
    var timeFormatColor: Color {
        configuration.timeFormatStyle.color
    }
    
    var headerTitleColor: Color {
        configuration.headerTitleStyle.color
    }
    
    var buttonsForegroundColor: Color {
        configuration.buttonStyle.color
    }
    
    var pickerBackgroundColor: Color {
        configuration.pickerBackgroundColor
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
        configuration.clockNumberStyle.color
    }
    
    var headerTitleFont: Font {
        configuration.headerTitleStyle.font
    }
    
    var timeLabelFont: Font {
        configuration.timeLabelStyle.font
    }
    
    var timeFormatFont: Font {
        configuration.timeFormatStyle.font
    }
    
    var selectedTimeFormatFont: Font {
        configuration.selectedTimeFormatStyle.font
    }
    
    var clockNumberFont: Font {
        configuration.clockNumberStyle.font
    }
    
    var buttonFont: Font {
        configuration.buttonStyle.font
    }
        
}
