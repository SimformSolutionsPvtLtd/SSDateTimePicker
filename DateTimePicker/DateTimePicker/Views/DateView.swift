//
//  DateView.swift
//  DateTimePicker
//
//  Created by Rizwana Desai on 23/11/23.
//

import SwiftUI

struct DateView: View, ConfigurationAccess {
    
    var configuration: SSCalendarConfiguration
    var date: Date
    var weekDateInSelectedMonth: Date

    @State var selectedDate: Date?
   
    //MARK: - Property
    private var isDayToday: Bool {
        calendar.isDateInToday(date)
    }
    private var isDaySelectableAndInRange: Bool {
        isDayWithinDateRange && isDayWithinWeekMonthAndYear && canSelectDay
    }
    
    //TODO: implement datasource method to check if the date is from preferd date range
    private var isDayWithinDateRange: Bool {
       true
    }
    
    private var isDayWithinWeekMonthAndYear: Bool {
        calendar.isDate(weekDateInSelectedMonth, equalTo: date, toGranularities: [.month, .year])
    }

    private var canSelectDay: Bool {
        true
    }

    private var isSelected: Bool {
        guard let selectedDate = selectedDate else { return false }
        return calendar.isDate(selectedDate, equalTo: date, toGranularities: [.day, .month, .year])
    }
    
    private var numericDay: String {
        String(calendar.component(.day, from: date))
    }

    private var foregroundColor: Color {
        if isDayToday {
            return SSCalendarTheme.todayTextColor
        } else {
            return SSCalendarTheme.dateMonthYearColor
        }
    }

    private var backgroundColor: some View {
        Group {
            if isSelected {
//                SSCalendarTheme.selectionColor
                SSCalendarTheme.themeColor
            }
            if isDayToday {
                SSCalendarTheme.todayBackgroundColor
            } else {
                Color.clear
            }
        }
    }

    private var opacity: Double {
        guard !isDayToday else { return 1 }
        return isDaySelectableAndInRange ? 1 : 0.15
    }

    //MARK: - init

    init(configuration: SSCalendarConfiguration, date: Date, weekDateInSelectedMonth: Date) {
        self.configuration = configuration
        self.date = date
        self.weekDateInSelectedMonth = weekDateInSelectedMonth
    }

    //MARK: - Body
    
    var body: some View {
        lblDate
    }
    
    //MARK: - Sub views
    
    var lblDate: some View {
        Text(numericDay)
            .font(.footnote)
            .foregroundColor(foregroundColor)
            .frame(width: SSCalendarConstants.widthForDaysOfWeek, height: SSCalendarConstants.widthForDaysOfWeek)
            .background(backgroundColor)
            .clipShape(Circle())
            .opacity(opacity)
            .onTapGesture(perform: updateSelection)
    }
    
    func updateSelection() {
        self.selectedDate = date
    }
}

struct DateView_Previews: PreviewProvider {
    static var previews: some View {
        DateView(configuration: SSCalendarConfiguration(), date: Date(), weekDateInSelectedMonth: Date())
    }
}
