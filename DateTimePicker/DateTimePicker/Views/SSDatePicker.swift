//
//  SSDatePicker.swift
//  DateTimePicker
//
//  Created by Rizwana Desai on 24/11/23.
//

import SwiftUI

public struct SSDatePicker: View, ConfigurationDirectAccess {
    
    //MARK: - Property
    @Binding var showCalender: Bool
    @State var currentView: SelectionView = .date
    @ObservedObject var calendarManager: SSCalendarManager
    
    var configuration: SSCalendarConfiguration {
        calendarManager.configuration
    }
    
    private var weeks: [Date] {
        guard let monthInterval = Calendar.current.dateInterval(of: .month, for: calendarManager.currentMonth) else {
            return []
        }
        print("Month Interval \(monthInterval)")
        return Calendar.current.generateDates(
            inside: monthInterval,
            matching: Calendar.current.firstDayOfEveryWeek)
    }
    
    //MARK: - init
    public init(showCalender: Binding<Bool>, calendarManager: ObservedObject<SSCalendarManager>) {
        self._showCalender = showCalender
        self._calendarManager = calendarManager
    }
    
    //MARK: - Sub views
    public var body: some View {
        ZStack(alignment: .center) {
            if showCalender {
                Color.black.opacity(0.5)
                    .ignoresSafeArea()
                calenderContainerView
                    .background(pickerBackgroundColor)
                    .cornerRadius(pickerViewRadius)
                    .padding(.leading, SSCalendarConstants.horizontalSpacing)
                    .padding(.trailing, SSCalendarConstants.horizontalSpacing)
                    .compositingGroup()
            }
        }
        .environmentObject(calendarManager)
    }
    
    var pickerContainerView: some View {
        ZStack(alignment: .center) {
            switch currentView {
            case .date:
                dateSectionView
            case .month:
                MonthSelectionView()
            case .year:
                YearSelectionView(currentView: $currentView)
            }
        }
    }
    
    var calenderContainerView: some View {
        VStack(alignment: .leading, spacing: 10) {
            calenderHeader
            pickerContainerView
            calenderFooterView
            bottomButtons
        }
        .padding(SSCalendarConstants.pickerViewInnerPadding)
    }
    
    var calenderHeader: some View {
        VStack(alignment: .leading, spacing: 10) {
            lblSelectedDate
            Divider()
        }
    }
    
    var dateSectionView: some View {
        VStack(alignment: .leading, spacing: 10) {
            daysOfWeekView
            datesView
        }
    }
    
    var lblSelectedDate: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Select Date")
                .font(.system(size: 12, weight: .bold))
                .foregroundColor(headerTitleColor)
            Text(calendarManager.selectedDate?.monthDateYear ?? calendarManager.currentMonth.monthYear)
                .font(.system(size: 19, weight: .semibold))
                .foregroundColor(headerDateColor)
        }
        .padding(10)
    }
    
    var daysOfWeekView: some View {
        HStack(spacing: 0) {
            ForEach(Calendar.current.shortWeekdaySymbols, id: \.self) { dayOfWeek in
                Text(dayOfWeek.prefix(1))
                    .font(.caption)
                    .frame(width: SSCalendarConstants.widthForDaysOfWeek)
                    .foregroundColor(weekdayTextColor)
                
            }
        }
    }
    
    var datesView: some View {
        ForEach(weeks, id: \.self) { week in
            WeekDatesView(week: week)
        }
    }
    
    var calenderFooterView: some View {
        HStack {
            btnPrevious
            Spacer()
            lblMonthYear
            Spacer()
            btnNext
        }
        .frame(maxWidth: .infinity)
        .padding(5)
    }
    
    var lblMonthYear: some View {
        Button {
            updateView()
        } label: {
            Text(currentMonthYear)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(monthYearNavigationLabelColor)
        }
    }
    
    var currentMonthYear: String {
        switch currentView {
        case .date:
            return calendarManager.currentMonth.monthYear
        case .month:
            return String(calendarManager.currentMonth.year)
        case .year:
            guard let startingYear = calendarManager.yearRange.first, let endYear = calendarManager.yearRange.last else {
                return String(calendarManager.currentMonth.year)
            }
            return "\(startingYear) - \(endYear)"
        }
    }
    
    var btnPrevious: some View {
        Button {
            self.calendarManager.actionPrev(for: currentView)
        } label: {
            Image(systemName: ImageConstant.chevronLeft)
                .foregroundColor(nextPrevButtonColor)
                .padding(5)
        }
    }
    
    var btnNext: some View {
        Button {
            self.calendarManager.actionNext(for: currentView)
        } label: {
            Image(systemName: ImageConstant.chevronRight)
                .foregroundColor(nextPrevButtonColor)
                .padding(5)
        }
    }
    
    var bottomButtons: some View {
        HStack(spacing: 5) {
            Spacer()
            btnCancel
            btnOk
        }
    }
    
    var btnCancel: some View {
        Button {
            self.actionCancel()
        } label: {
            Text("Cancel")
                .font(.system(size: 15, weight: .semibold))
                .padding(10)
                .foregroundColor(cancelBtnColor)
        }
    }
    
    var btnOk: some View {
        Button {
            self.actionOk()
        } label: {
            Text("Ok")
                .font(.system(size: 15, weight: .semibold))
                .padding(10)
                .foregroundColor(okBtnColor)
        }
    }
    
    func updateView() {
        switch currentView {
        case .date:
            currentView = .month
        case .month:
            currentView = .year
        case .year:
            currentView = .date
        }
    }

}


extension SSDatePicker {
    
    //MARK: - Action methods
    
    func actionCancel() {
        calendarManager.selectionCanceled(for: currentView)
        switch currentView {
        case .date:
            showCalender = false
            currentView = .date
        case .month:
            currentView = .date
        case .year:
            currentView = .month
        }
    }
    
    func actionOk() {
        self.calendarManager.selectionConfirmed(for: currentView)
        switch currentView {
        case .year, .month:
            currentView = .date
        case .date:
            showCalender = false
            currentView = .date
        }
    }
    
}

//struct ThemeCalederView_Previews: PreviewProvider {
//    static var previews: some View {
//        ThemeCalederView(showCalender: .constant(true), calendarManager: SSCalendarManager(currentMonth: Date()))
//    }
//}

