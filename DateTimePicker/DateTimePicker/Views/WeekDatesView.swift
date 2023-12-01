//
//  DatesView.swift
//  DateTimePicker
//
//  Created by Rizwana Desai on 23/11/23.
//

import SwiftUI

struct WeekDatesView: View, ConfigurationDirectAccess {
    
    //MARK: - Property

    @EnvironmentObject var calendarManager: SSCalendarManager
    var week: Date
    var configuration: SSCalendarConfiguration {
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
        HStack(spacing: 0) {
            ForEach(dates, id: \.self) { date in
                DateView(date: date, weekDateInSelectedMonth: week)
            }
        }
    }
    
}

struct DatesView_Previews: PreviewProvider {
    static var previews: some View {
        WeekDatesView(week: Date())
    }
}
