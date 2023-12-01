//
//  DateView.swift
//  DateTimePicker
//
//  Created by Rizwana Desai on 23/11/23.
//

import SwiftUI

struct DateView: View, ConfigurationDirectAccess {
    
    //MARK: - Property
    
    @EnvironmentObject var calendarManager: SSCalendarManager
    
    var date: Date
    var weekDateInSelectedMonth: Date
    var configuration: SSCalendarConfiguration {
        calendarManager.configuration
    }
    
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
        guard let selectedDate = calendarManager.selectedDate else { return false }
        return calendar.isDate(selectedDate, equalTo: date, toGranularities: [.day, .month, .year])
    }
    
    private var numericDay: String {
        String(calendar.component(.day, from: date))
    }
    
    private var foregroundColor: Color {
        if isDayToday {
            return todayColor
        } else {
            return dateMonthYearTextColor
        }
    }
    
    private var backgroundColor: Color {
        if isSelected {
            return selectionBackgroundColor
        } else if isDayToday {
            return todaySelectionColor
        } else {
            return Color.clear
        }
    }
    
    private var opacity: Double {
        return isDaySelectableAndInRange ? 1 : 0.15
    }
    
    //MARK: - init
    
    init(date: Date, weekDateInSelectedMonth: Date) {
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
        guard isDaySelectableAndInRange else { return }
        self.calendarManager.updateDateSelection(date: date)
    }
}

struct DateView_Previews: PreviewProvider {
    static var previews: some View {
        DateView(date: Date(), weekDateInSelectedMonth: Date())
    }
}
