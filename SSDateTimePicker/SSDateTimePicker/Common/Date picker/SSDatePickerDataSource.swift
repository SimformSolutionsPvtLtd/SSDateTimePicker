//
//  SSDatePickerDataSource.swift
//  DateTimePicker
//
//  Created by Rizwana Desai on 08/12/23.
//

import Foundation
import SwiftUI

public protocol SSDatePickerDataSource: AnyObject {
    
    func datePicker(canSelectDate date: Date) -> Bool
    func datePicker(backgroundColorOpacityForDate date: Date) -> Double
    func datePicker(viewForSelectedDate date: Date, dimensions size: CGSize) -> AnyView
    
}

public extension SSDatePickerDataSource {
    
    func datePicker(canSelectDate date: Date) -> Bool { true }
    func datePicker(backgroundColorOpacityForDate date: Date) -> Double { 1 }
    func datePicker(viewForSelectedDate date: Date, dimensions size: CGSize) -> AnyView {
        AnyView(EmptyView())
    }
    
}
