//
//  DatesView.swift
//  DateTimePicker
//
//  Created by Rizwana Desai on 23/11/23.
//

import SwiftUI

struct WeekDatesView: View, DatePickerConfigurationDirectAccess {
    
    //MARK: - Property
    
    @EnvironmentObject var calendarManager: SSDatePickerManager
    var week: Date
    
    var configuration: SSDatePickerConfiguration {
        calendarManager.configuration
    }
    
    private var dates: [Date] {
        guard let weekInterval = calendar.dateInterval(of: .weekOfYear, for: week) else {
            return []
        }
        return calendar.generateDates(
            inside: weekInterval,
            matching: .everyDay)
    }
    
    //MARK: - init
    init(week: Date) {
        self.week = week
    }
    
    //MARK: - Body
    
    var body: some View {
        datesForWeek
    }
    
    //MARK: - Sub views
    
    var datesForWeek: some View {
        HStack(spacing: SSPickerConstants.horizontalSpacingDates) {
            ForEach(dates, id: \.self) { date in
                DateView(date: date, weekDateInSelectedMonth: week)
            }
        }
    }
    
}
