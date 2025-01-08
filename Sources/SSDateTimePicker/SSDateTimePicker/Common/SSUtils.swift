//
//  SSUtils.swift
//  SSDateTimePicker
//
//  Created by Rizwana Desai on 18/12/23.
//

import Foundation
import SwiftUI

// MARK: - typealias

public typealias DateRange = (startDate: Date, endDate: Date)
public typealias Time = Date

// MARK: - SelectionView enum

/// Enum representing different views available in a datetime picker.
public enum SelectionView {
    
    /// Date view, allowing selection of day, month, and year.
    case date
    
    /// Month view, allowing selection of month and year.
    case month
    
    /// Year view, allowing selection of the year.
    case year
    
}

// MARK: - TimeFormat enum

/// Enum representing different time formats for a time picker.
enum TimeFormat {
    case am
    case pm
}

// MARK: - View style

public struct SSStyle {
    public var font: Font
    public var color: Color
    
    init(font: Font, color: Color) {
        self.font = font
        self.color = color
    }
}

public struct SSColor {
    public var foregroundColor: Color?
    public var backgroundColor: Color?
    
    init(foregroundColor: Color? = nil, backgroundColor: Color? = nil) {
        self.foregroundColor = foregroundColor
        self.backgroundColor = backgroundColor
    }
}

// MARK: - Font used in SSDateTimePicker

extension Font {
    static let headerTitle: Font = .system(size: Size.headerTitle, weight: .bold)
    static let headerDate: Font = .system(size: Size.headerDate, weight: .semibold)
    static let weekday: Font = .caption
    static let date: Font = .footnote
    static let month: Font = .system(size: Size.month, weight: .regular)
    static let selectedMonth: Font = .system(size: Size.month, weight: .bold)
    static let year: Font = .system(size: Size.year, weight: .regular)
    static let selectedYear: Font = .system(size: Size.year, weight: .bold)
    static let buttonText: Font = .system(size: Size.buttonsText, weight: .semibold)
    static let currentMonthYear: Font = .system(size: Size.currentMonthYear, weight: .medium)
    static let clockNumber: Font = .system(size: Size.clockNumber)
    static let timeLabel: Font = .system(size: Size.timeLabel, weight: .semibold)
    static let timeFormat: Font = .system(size: Size.timeFormat, weight: .bold)
    static let selectedTimeFormat: Font = .system(size: Size.selectedTimeFormat, weight: .bold)
}
