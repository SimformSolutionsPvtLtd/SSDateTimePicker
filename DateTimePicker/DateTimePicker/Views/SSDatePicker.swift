//
//  SSDatePicker.swift
//  DateTimePicker
//
//  Created by Rizwana Desai on 24/11/23.
//

import SwiftUI

public struct SSDatePicker: View, DatePickerConfigurationDirectAccess {
    
    //MARK: - Property
    @Binding var showCalender: Bool
    @State var currentView: SelectionView = .date
    @ObservedObject var datePickerManager: SSDatePickerManager
    
    var configuration: SSDatePickerConfiguration {
        datePickerManager.configuration
    }
    
    private var weeks: [Date] {
        guard let monthInterval = calendar.dateInterval(of: .month, for: datePickerManager.currentMonth) else {
            return []
        }
        return calendar.generateDates(
            inside: monthInterval,
            matching: calendar.firstDayOfEveryWeek)
    }
    
    //MARK: - init
    public init(showCalender: Binding<Bool>, calendarManager: ObservedObject<SSDatePickerManager>) {
        self._showCalender = showCalender
        self._datePickerManager = calendarManager
    }
    
    //MARK: - Sub views
    public var body: some View {
        ZStack(alignment: .center) {
            if showCalender {
                popupOverlayColor
                    .ignoresSafeArea()
                calenderContainerView
                    .background(pickerBackgroundColor)
                    .cornerRadius(pickerViewRadius)
                    .padding(.leading, SSPickerConstants.pickerLeadingTrailing)
                    .padding(.trailing, SSPickerConstants.pickerLeadingTrailing)
                    .compositingGroup()
            }
        }
        .environmentObject(datePickerManager)
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
        VStack(alignment: .leading, spacing: SSPickerConstants.verticleSpacingTen) {
            datePickerHeader
            pickerContainerView
            calenderFooterView
            bottomButtons
        }
        .padding(SSPickerConstants.pickerViewInnerPadding)
    }
    
    var datePickerHeader: some View {
        VStack(alignment: .leading, spacing: SSPickerConstants.verticleSpacingTen) {
            lblSelectedDate
            Divider()
        }
    }
    
    var dateSectionView: some View {
        VStack(alignment: .leading, spacing: SSPickerConstants.verticleSpacingTen) {
            daysOfWeekView
            datesView
        }
    }
    
    var lblSelectedDate: some View {
        VStack(alignment: .leading, spacing: SSPickerConstants.verticleSpacingTen) {
            Text("Select Date")
                .font(.system(size: 12, weight: .bold))
                .foregroundColor(headerTitleColor)
            Text(datePickerManager.selectedDate?.formatedString(headerDateFormat) ?? datePickerManager.currentMonth.monthYear)
                .font(.system(size: 19, weight: .semibold))
                .foregroundColor(headerDateColor)
        }
        .padding(SSPickerConstants.paddingTen)
    }
    
    var daysOfWeekView: some View {
        HStack(spacing: SSPickerConstants.horizontalSpacingDates) {
            ForEach(calendar.shortWeekdaySymbols, id: \.self) { dayOfWeek in
                Text(dayOfWeek.prefix(1))
                    .font(.caption)
                    .frame(width: SSPickerConstants.widthForDaysOfWeek)
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
        .padding(SSPickerConstants.paddingFive)
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
            return datePickerManager.currentMonth.monthYear
        case .month:
            return String(datePickerManager.currentMonth.year(calendar))
        case .year:
            guard let startingYear = datePickerManager.yearRange.first, let endYear = datePickerManager.yearRange.last else {
                return String(datePickerManager.currentMonth.year(calendar))
            }
            return "\(startingYear) - \(endYear)"
        }
    }
    
    var btnPrevious: some View {
        Button {
            self.datePickerManager.actionPrev(for: currentView)
        } label: {
            self.imageNextPrev(ImageConstant.chevronLeft)
        }
    }
    
    var btnNext: some View {
        Button {
            self.datePickerManager.actionNext(for: currentView)
        } label: {
            self.imageNextPrev(ImageConstant.chevronRight)
        }
    }
    
    func imageNextPrev(_ name: String) -> some View {
        Image(systemName: name)
            .foregroundColor(nextPrevButtonColor)
            .padding(SSPickerConstants.paddingFive)
    }
    
    var bottomButtons: some View {
        HStack(spacing: SSPickerConstants.bottomButtonHSpacing) {
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
                .themeButton(buttonsForegroundColor)
        }
    }
    
    var btnOk: some View {
        Button {
            self.actionOk()
        } label: {
            Text("Ok")
                .themeButton(buttonsForegroundColor)
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
        datePickerManager.selectionCanceled(for: currentView)
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
        self.datePickerManager.selectionConfirmed(for: currentView)
        switch currentView {
        case .year, .month:
            currentView = .date
        case .date:
            showCalender = false
            currentView = .date
        }
    }
    
}
