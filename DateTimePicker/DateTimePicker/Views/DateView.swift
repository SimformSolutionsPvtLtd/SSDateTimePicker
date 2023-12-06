//
//  DateView.swift
//  DateTimePicker
//
//  Created by Rizwana Desai on 23/11/23.
//

import SwiftUI

struct DateView: View, DatePickerConfigurationDirectAccess {
    
    //MARK: - Property
    
    @EnvironmentObject var calendarManager: SSDatePickerManager
    var date: Date
    var weekDateInSelectedMonth: Date
    
    var configuration: SSDatePickerConfiguration {
        calendarManager.configuration
    }
    
    private var isDayToday: Bool {
        calendar.isDateInToday(date)
    }
    
    private var isDaySelectableAndInRange: Bool {
        isDayWithinDateRange && isDayWithinWeekMonthAndYear && canSelectDay
    }
    
    private var canSelectFutureDate: Bool {
        guard disableFutureDates else { return true }
        return date <= calendar.startOfDay(for: Date())
    }

    private var canSelectPastDate: Bool {
        guard disablePastDates else { return true }
        return date >= calendar.startOfDay(for: Date())
    }

    private var isDayWithinDateRange: Bool {
        guard let minimumDate, let maximumDate else { return true }
        return date >= calendar.startOfDay(for: minimumDate) && date <= maximumDate
    }
    
    private var isDayWithinWeekMonthAndYear: Bool {
        calendar.isDate(weekDateInSelectedMonth, equalTo: date, toGranularities: [.month, .year])
    }
    
    private var canSelectDay: Bool {
        (calendarManager.datasource?.datePicker(canSelectDate: date) ?? true) && canSelectPastDate && canSelectFutureDate
    }
    
    private var isSelected: Bool {
        if allowMultipleSelection {
            return isSelectedDatesContainSameDate
        } else {
            return isSelectedDateSame
        }
    }
    
    private var numericDay: String {
        String(calendar.component(.day, from: date))
    }
    
    private var foregroundColor: Color {
        if isDayToday {
            return todayColor
        } else if isSelected {
            return Color.white
        } else {
            return dateMonthYearTextColor
        }
    }
    
    private var backgroundColor: Color {
        if isSelected || isStartDate || isEndDate {
            return selectionBackgroundColor
        } else if isDayToday {
            return todaySelectionColor
        } else if isDayWithinSelectedDateRange {
            return selectionBackgroundColor.opacity(0.3)
        } else {
            return Color.clear
        }
    }
    
    private var opacity: Double {
        return isDaySelectableAndInRange ? 1 : 0.15
    }
    
    private var isSelectedDateSame: Bool {
        guard let selectedDate = calendarManager.selectedDate else { return false }
        return calendar.isDate(selectedDate, equalTo: date, toGranularities: [.day, .month, .year])
    }
    
    private var isSelectedDatesContainSameDate: Bool {
        guard let selectedDates = calendarManager.selectedDates else { return false }
        for selectedDate in selectedDates {
            if calendar.isDate(selectedDate, equalTo: date, toGranularities: [.day, .month, .year]) {
                return true
            }
        }
        return false
    }
    
    private var isDayWithinSelectedDateRange: Bool {
        guard let startDate = calendarManager.startDate, let endDate = calendarManager.endDate else { return false }
        return date >= calendar.startOfDay(for: startDate) && date <= endDate
    }
    
    private var isStartDate: Bool {
        guard let startDate = calendarManager.startDate else { return false }
        return calendar.isDate(startDate, equalTo: date, toGranularities: [.day, .month, .year])
    }
    
    private var isEndDate: Bool {
        guard let endDate = calendarManager.endDate else { return false }
        return calendar.isDate(endDate, equalTo: date, toGranularities: [.day, .month, .year])
    }
    
    private var corners: UIRectCorner {
        isStartDate ? [.topLeft,.bottomLeft] : [.topRight,.bottomRight]
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
            .frame(width: SSPickerConstants.widthForDaysOfWeek, height: SSPickerConstants.widthForDaysOfWeek)
            .if(!allowRangeSelection, transform: { view in
                view
                    .background(Circle()
                        .padding(.leading, SSPickerConstants.selectionCirclePadding)
                        .padding(.trailing, SSPickerConstants.selectionCirclePadding)
                        .foregroundColor(backgroundColor))
            })
                .if(allowRangeSelection, transform: { view in
                    view
                        .background(backgroundColor)
                        .cornerRadius((isStartDate || isEndDate) ? SSPickerConstants.dateRangeSelectionCornerRadius : 0, corners: corners)
                })
                    .opacity(opacity)
                    .onTapGesture(perform: updateSelection)
    }
    
    //MARK: - Methods

    func updateSelection() {
        guard isDaySelectableAndInRange else { return }
        self.calendarManager.updateDateSelection(date: date)
    }
    
}
