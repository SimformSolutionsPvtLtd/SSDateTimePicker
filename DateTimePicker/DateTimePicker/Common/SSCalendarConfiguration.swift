//
//  SSCalendarConfiguration.swift
//  DateTimePicker
//
//  Created by Rizwana Desai on 23/11/23.
//

import Foundation


public struct SSCalendarConfiguration {
    
    var calendar: Calendar
//    var selectedDate: Date
//    var isFututreSelectionDisable: Bool
    
    
    public init() {
        self.calendar = Calendar.current
        
    }
    
    
}


protocol ConfigurationAccess {

    var configuration: SSCalendarConfiguration { get }

}

extension ConfigurationAccess {
    
    var calendar: Calendar {
        configuration.calendar
    }
    
}
