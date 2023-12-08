//
//  SSTimePickerDelegate.swift
//  DateTimePicker
//
//  Created by Rizwana Desai on 08/12/23.
//

import Foundation

public protocol SSTimePickerDelegate: AnyObject {
    
    /// Notifies the delegate when a Time is selected.
    /// - Parameter selectedTime: The selected time.
    func timePicker(didSelectTime selectedTime: Date)
    
}
