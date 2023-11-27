//
//  ThemeCalederView.swift
//  DateTimePicker
//
//  Created by Rizwana Desai on 24/11/23.
//

import SwiftUI

public struct ThemeCalederView: View, ConfigurationAccess {
    
    //MARK: - Property
    @Binding var showCalender: Bool
    
    @State var showDatePicker: Bool = true
    @State var showMonthPicker: Bool = false
    @State var showYearPicker: Bool = false
//    @State var visibleCalendarMonth: Date = Date()

    @StateObject var calendarManager: SSCalendarManager = SSCalendarManager(currentMonth: Date())
    var configuration: SSCalendarConfiguration
    
    private var weeks: [Date] {
        guard let monthInterval = calendar.dateInterval(of: .month, for: calendarManager.currentMonth) else {
            return []
        }
        print("Month Interval \(monthInterval)")
        return calendar.generateDates(
            inside: monthInterval,
            matching: calendar.firstDayOfEveryWeek)
    }
    
    //MARK: - init
    public init(showCalender: Binding<Bool>) {
        self.configuration = SSCalendarConfiguration()
        self._showCalender = showCalender
//        self._calendarManager = calendarManager
    }
    
    //MARK: - Sub views
    public var body: some View {
        ZStack(alignment: .center) {
            if showCalender {
                Color.black.opacity(0.5)
                    .ignoresSafeArea()
                calenderContainerView
                    .background(Color.lightGreen)
                    .cornerRadius(15)
                    .padding(.leading, SSCalendarConstants.horizontalSpacing)
                    .padding(.trailing, SSCalendarConstants.horizontalSpacing)
                    .compositingGroup()
//                    .shadow(color: Color.lightGreen, radius: 10, x: 0, y: 0)
            }
        }
        .environmentObject(calendarManager)
        .onChange(of: showCalender) { showCalender in
            showDatePicker = showCalender
        }
    }
    
    var pickerContainerView: some View {
        ZStack(alignment: .center) {
            if showDatePicker {
                dateSectionView
            }
            if showMonthPicker {
                MonthSelectionView()
            }
            if showYearPicker {
                YearSelectionView(selectedYear: .constant(2022))
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
        .padding(8)
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
                .foregroundColor(Color.gray)
            Text("Nov 24, 2023")
                .font(.system(size: 19, weight: .semibold))
                .foregroundColor(Color.black)
        }
        .padding(10)
            
    }
    
    var daysOfWeekView: some View {
        HStack {
            ForEach(calendar.shortWeekdaySymbols, id: \.self) { dayOfWeek in
                Text(dayOfWeek.prefix(1))
                    .font(.caption)
                    .frame(width: SSCalendarConstants.widthForDaysOfWeek)
                    .foregroundColor(.gray)

            }
        }
    }
    
    var datesView: some View {
        ForEach(weeks, id: \.self) { week in
            WeekDatesView(configuration: configuration, week: week)
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
            if showDatePicker {
                self.showMonthPicker = true
                self.showDatePicker = false
            } else if showMonthPicker {
                self.showYearPicker = true
                self.showMonthPicker = false
            } else {
                self.showYearPicker = false
                self.showDatePicker = true
            }
        } label: {
            Text(calendarManager.currentMonth.monthYear)
                .font(.system(size: 14, weight: .regular))
                .foregroundColor(Color.themeBlack)
        }
    }
    
    var btnPrevious: some View {
        Button {
            self.calendarManager.actionPrev(for: !showDatePicker)
        } label: {
            Image(systemName: ImageConstant.chevronLeft)
                .foregroundColor(Color.gray)
                .padding(5)
        }
    }
    
    var btnNext: some View {
        Button {
            self.calendarManager.actionNext(for: !showDatePicker)
        } label: {
            Image(systemName: ImageConstant.chevronRight)
                .foregroundColor(Color.gray)
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
                .foregroundColor(Color.darkGreen)
        }
    }
    
    var btnOk: some View {
        Button {
            self.actionOk()
        } label: {
            Text("Ok")
                .font(.system(size: 15, weight: .semibold))
                .padding(10)
                .foregroundColor(Color.darkGreen)
        }
    }
    
}


extension ThemeCalederView {
    
    //MARK: - Action methods
    
    func actionCancel() {
        showCalender = false
        showMonthPicker = false
        showDatePicker = false
        showYearPicker = false
    }
    
    func actionOk() {
        showCalender.toggle()
        showDatePicker.toggle()
        showMonthPicker = false
        showYearPicker = false
    }
  
    func actionNextYear() {
         
    }
    
    func actionPreviousYear() {
         
    }
    
}

//struct ThemeCalederView_Previews: PreviewProvider {
//    static var previews: some View {
//        ThemeCalederView(showCalender: .constant(true), calendarManager: SSCalendarManager(currentMonth: Date()))
//    }
//}
