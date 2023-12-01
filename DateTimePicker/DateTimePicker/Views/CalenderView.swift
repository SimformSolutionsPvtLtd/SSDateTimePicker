//
//  CalenderView.swift
//  
//
//  Created by Rizwana Desai on 22/11/23.
//

import SwiftUI

public struct CalenderView: View, ConfigurationAccess {
    
    //MARK: - Property
    @Binding var showCalender: Bool
    
    @State var showDatePicker: Bool = true
    @State var showMonthPicker: Bool = false
    @State var showYearPicker: Bool = false

    var configuration: SSCalendarConfiguration
    @State var visibleCalendarMonth: Date = Date()
    
    private var weeks: [Date] {
        guard let monthInterval = calendar.dateInterval(of: .month, for: visibleCalendarMonth) else {
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
    }
    
    //MARK: - Sub views
    public var body: some View {
        ZStack(alignment: .center) {
            if showCalender {
                Color.black.opacity(0.5)
                    .ignoresSafeArea()
                calenderContainerView
                    .background(Color.white)
                    .padding(.leading, SSCalendarConstants.horizontalSpacing)
                    .padding(.trailing, SSCalendarConstants.horizontalSpacing)
                    .compositingGroup()
                    .shadow(color: Color.black, radius: 10, x: 0, y: 0)
            }
        }
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
            lblSelectedDate
            pickerContainerView
            calenderFooterView
            bottomButtons
        }
        .padding(8)
    }
    
    var dateSectionView: some View {
        VStack(alignment: .leading, spacing: 10) {
            daysOfWeekView
            datesView
        }
    }
    
    var lblSelectedDate: some View {
        Text("22nd November, 2023")
            .font(.subheadline)
            .foregroundColor(SSCalendarTheme.themeColor)
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
                .padding(.leading, 10)
            Spacer()
            lblMonthYear
            Spacer()
            btnNext
                .padding(.trailing, 10)

        }
        .frame(maxWidth: .infinity)
        .padding(10)
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
            Text(visibleCalendarMonth.monthYear)
                .foregroundColor(SSCalendarTheme.primary)
        }
    }
    
    var btnPrevious: some View {
        Button {
            self.actionPrevious()
        } label: {
            Image(systemName: ImageConstant.chevronLeft)
                .foregroundColor(SSCalendarTheme.primary)
        }
    }
    
    var btnNext: some View {
        Button {
            self.actionNext()
        } label: {
            Image(systemName: ImageConstant.chevronRight)
                .foregroundColor(SSCalendarTheme.primary)
        }
    }
    
    var bottomButtons: some View {
        HStack(spacing: 15) {
            Spacer()
            btnCancel
            btnOk
        }
        .padding(.bottom, 8)
        .padding(.trailing, 15)
    }
    
    var btnCancel: some View {
        Button {
            self.actionCancel()
        } label: {
            Text("Cancel")
                .foregroundColor(SSCalendarTheme.themeColor)
        }
    }
    
    var btnOk: some View {
        Button {
            self.actionOk()
        } label: {
            Text("Ok")
                .foregroundColor(SSCalendarTheme.themeColor)
        }
    }
    
}

extension CalenderView {
    
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
    
    func actionNext() {
        withAnimation {
            self.actionNextMonth()
        }
    }
    
    func actionPrevious() {
        withAnimation {
            self.actionPreviousMonth()
        }
    }
    
    func actionNextMonth() {
        guard let date =  visibleCalendarMonth.getNextMonth() else { return }
        self.visibleCalendarMonth = date
    }
    
    func actionPreviousMonth() {
        guard let date =  visibleCalendarMonth.getPreviousMonth() else { return }
        self.visibleCalendarMonth = date
    }
    
    func actionNextYear() {
         
    }
    
    func actionPreviousYear() {
         
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CalenderView(showCalender: .constant(true))
    }
}
