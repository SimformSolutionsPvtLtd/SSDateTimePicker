//
//  DatesView.swift
//  DateTimePicker
//
//  Created by Rizwana Desai on 23/11/23.
//

import SwiftUI

struct WeekDatesView: View, ConfigurationAccess {
    
    //MARK: - Property

    var configuration: SSCalendarConfiguration
    var week: Date
    
    private var dates: [Date] {
        guard let weekInterval = calendar.dateInterval(of: .weekOfYear, for: week) else {
            return []
        }
        return calendar.generateDates(
            inside: weekInterval,
            matching: .everyDay)
    }
    
    //MARK: - init
    init(configuration: SSCalendarConfiguration, week: Date) {
        self.configuration = configuration
        self.week = week
    }
    
    //MARK: - Body

    var body: some View {
        datesForWeek
    }
    
    //MARK: - Sub views
    
    var datesForWeek: some View {
        HStack {
            ForEach(dates, id: \.self) { date in
                DateView(configuration: configuration, date: date, weekDateInSelectedMonth: week)
            }
        }
    }
}

struct DatesView_Previews: PreviewProvider {
    static var previews: some View {
        WeekDatesView(configuration: SSCalendarConfiguration(), week: Date())
    }
}
