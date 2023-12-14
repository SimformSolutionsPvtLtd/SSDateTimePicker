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
    
    //MARK: - Initializer
    
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
                    .onTapGesture {
                        actionCancel()
                    }
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
        VStack(alignment: .leading, spacing: SSPickerConstants.paddingFive) {
            lblSelectedDate
            Divider()
                .background(sepratorLineColor)
                .padding(.bottom, SSPickerConstants.deviderBottomPadding)
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
            Text(LocalizedString.selectDate)
                .font(headerTitleFont)
                .foregroundColor(headerTitleColor)
            Text(datePickerManager.selectedDate?.formatedString(headerDateFormat) ?? datePickerManager.currentMonth.monthYear)
                .font(headerDateFont)
                .foregroundColor(headerDateColor)
        }
        .padding(SSPickerConstants.paddingTen)
    }
    
    var daysOfWeekView: some View {
        HStack(spacing: SSPickerConstants.horizontalSpacingDates) {
            ForEach(calendar.shortWeekdaySymbols, id: \.self) { dayOfWeek in
                Text(dayOfWeek.prefix(1))
                    .font(weekdayTextFont)
                    .frame(width: SSPickerConstants.widthForDaysOfWeek)
                    .foregroundColor(weekdayTextColor)
            }
        }
    }
    
    var datesView: some View {
        VStack(spacing: SSPickerConstants.verticleSpacingDates) {
            ForEach(weeks, id: \.self) { week in
                WeekDatesView(week: week)
            }
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
            withAnimation {
                updateView()
            }
        } label: {
            Text(currentMonthYear)
                .font(currentMonthYearBottomLabelFont)
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
            .foregroundColor(buttonsForegroundColor)
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
            withAnimation {
                self.actionCancel()
            }
        } label: {
            Text(LocalizedString.cancel)
                .themeButton(buttonsForegroundColor, buttonsFont)
        }
    }
    
    var btnOk: some View {
        Button {
            withAnimation {
                self.actionOk()
            }
        } label: {
            Text(LocalizedString.ok)
                .themeButton(buttonsForegroundColor, buttonsFont)
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
