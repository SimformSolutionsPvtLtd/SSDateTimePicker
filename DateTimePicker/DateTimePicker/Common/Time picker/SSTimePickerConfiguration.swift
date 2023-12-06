//
//  SSTimePickerConfiguration.swift
//  DateTimePicker
//
//  Created by Rizwana Desai on 04/12/23.
//

import Foundation
import SwiftUI

public struct SSTimePickerConfiguration {
    
    public var timeTextBackgroundColor: Color = Color.peach
    public var timeForegroundColor: Color = Color.darkPink
    public var timeFormatSelectionColor: Color = Color.darkPink
    public var timeFormatColor: Color = Color.gray
    public var headerTitleCoor: Color = Color.gray
    public var buttonsForegroundColor: Color = Color.darkPink
    public var pickerBackgroundColor: Color = Color.lightPink
    public var timeSelectionBgColor: Color = Color.darkPink
    public var timeSelectionForegroundColor: Color = Color.white
    public var popupOverlayColor: Color = Color.black.opacity(0.5)
    public var clockHandColor: Color = Color.darkPink
    public var clockNumberTextColor: Color = Color.black

    // Corner radius
    public var pickerViewRadius: CGFloat = 15
    
    public init() {
        
    }

}

protocol TimePickerConfigurationDirectAccess {
    
    var configuration: SSTimePickerConfiguration { get }
    
}

extension TimePickerConfigurationDirectAccess {
    
    var timeTextBackgroundColor: Color {
        configuration.timeTextBackgroundColor
    }
    
    var timeForegroundColor: Color {
        configuration.timeForegroundColor
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
    
    var timeSelectionBgColor: Color {
        configuration.timeSelectionBgColor
    }
    
    var timeSelectionForegroundColor: Color {
        configuration.timeSelectionForegroundColor
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
        
}
