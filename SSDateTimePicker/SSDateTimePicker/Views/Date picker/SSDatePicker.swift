//
//  SSDatePicker.swift
//  DateTimePicker
//
//  Created by Rizwana Desai on 24/11/23.
//

import SwiftUI

public struct SSDatePicker: View, DatePickerConfigurationDirectAccess {
    
    //MARK: - Properties
    
    @Binding var showDatePicker: Bool
    @State var currentView: SelectionView = .date
    @ObservedObject var datePickerManager: SSDatePickerManager = SSDatePickerManager()
    
    var configuration: SSDatePickerConfiguration {
        get {
            datePickerManager.configuration
        }
        set {
            datePickerManager.configuration = newValue
        }
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
    
    public init(showDatePicker: Binding<Bool>) {
        self._showDatePicker = showDatePicker
    }
    
    //MARK: - Sub views
    
    public var body: some View {
        ZStack(alignment: .center) {
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
        .environmentObject(datePickerManager)
    }
    
    private var pickerContainerView: some View {
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
    
    private var calenderContainerView: some View {
        VStack(alignment: .leading, spacing: SSPickerConstants.verticleSpacingTen) {
            datePickerHeader
            pickerContainerView
            calenderFooterView
            bottomButtons
        }
        .padding(SSPickerConstants.pickerViewInnerPadding)
    }
    
    private var datePickerHeader: some View {
        VStack(alignment: .leading, spacing: SSPickerConstants.paddingFive) {
            lblSelectedDate
            Divider()
                .background(sepratorLineColor)
                .padding(.bottom, SSPickerConstants.deviderBottomPadding)
        }
    }
    
    private var dateSectionView: some View {
        VStack(alignment: .leading, spacing: SSPickerConstants.verticleSpacingTen) {
            daysOfWeekView
            datesView
        }
    }
    
    private var lblSelectedDate: some View {
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
    
    private var daysOfWeekView: some View {
        HStack(spacing: SSPickerConstants.horizontalSpacingDates) {
            ForEach(calendar.shortWeekdaySymbols, id: \.self) { dayOfWeek in
                Text(dayOfWeek.prefix(1))
                    .font(weekdayTextFont)
                    .frame(width: SSPickerConstants.widthForDaysOfWeek)
                    .foregroundColor(weekdayTextColor)
            }
        }
    }
    
    private var datesView: some View {
        VStack(spacing: SSPickerConstants.verticleSpacingDates) {
            ForEach(weeks, id: \.self) { week in
                WeekDatesView(week: week)
            }
        }
    }
    
    private var calenderFooterView: some View {
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
    
    private var lblMonthYear: some View {
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
    
    private var currentMonthYear: String {
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
    
    private var btnPrevious: some View {
        Button {
            self.datePickerManager.actionPrev(for: currentView)
        } label: {
            self.imageNextPrev(ImageConstant.chevronLeft)
        }
    }
    
    private var btnNext: some View {
        Button {
            self.datePickerManager.actionNext(for: currentView)
        } label: {
            self.imageNextPrev(ImageConstant.chevronRight)
        }
    }
    
    private func imageNextPrev(_ name: String) -> some View {
        Image(systemName: name)
            .foregroundColor(buttonsForegroundColor)
            .padding(SSPickerConstants.paddingFive)
    }
    
    private var bottomButtons: some View {
        HStack(spacing: SSPickerConstants.bottomButtonHSpacing) {
            Spacer()
            btnCancel
            btnOk
        }
    }
    
    private var btnCancel: some View {
        Button {
            withAnimation {
                self.actionCancel()
            }
        } label: {
            Text(LocalizedString.cancel)
                .themeButton(buttonsForegroundColor, buttonsFont)
        }
    }
    
    private var btnOk: some View {
        Button {
            withAnimation {
                self.actionOk()
            }
        } label: {
            Text(LocalizedString.ok)
                .themeButton(buttonsForegroundColor, buttonsFont)
        }
    }
    
    private func updateView() {
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
    
    private func actionCancel() {
        datePickerManager.selectionCanceled(for: currentView)
        switch currentView {
        case .date:
            showDatePicker = false
            currentView = .date
        case .month:
            currentView = .date
        case .year:
            currentView = .month
        }
    }
    
    private func actionOk() {
        self.datePickerManager.selectionConfirmed(for: currentView)
        switch currentView {
        case .year, .month:
            currentView = .date
        case .date:
            showDatePicker = false
            currentView = .date
        }
    }
    
}

// MARK: - Modifiers

extension SSDatePicker {
    
    /// Creates a custom-themed date picker.
    /// - Parameters:
    ///   - pickerBackgroundColor: The background color of the picker view. Default is light pink.
    ///   - primaryColor: The color for both the selected date's background and the buttons. Deafult is dark pink.
    /// - Returns: An updated SSDatePicker instance.
    public func themeColor(pickerBackgroundColor: Color = Color.lightPink, primaryColor: Color = Color.darkPink) -> SSDatePicker {
        var picker = self
        picker.configuration.selectedDateColor.backgroundColor = primaryColor
        picker.configuration.buttonStyle.color = primaryColor
        picker.configuration.pickerBackgroundColor = pickerBackgroundColor
        return picker
    }
    
    /// Sets the style for the header title in the date picker. 'Select Date'
    /// - Parameters:
    ///   - color: The color of the header title.
    ///   - font: The font of the header title.
    /// - Returns: An updated SSDatePicker instance.
    public func headerTitleStyle(color: Color? = nil, font: Font? = nil) -> SSDatePicker {
        var picker = self
        color.map { picker.configuration.headerTitleStyle.color = $0 }
        font.map { picker.configuration.headerTitleStyle.font = $0 }
        return picker
    }
    
    /// Sets the style for the header date in the date picker.
    /// - Parameters:
    ///   - color: The color of the header date.
    ///   - font: The font of the header date.
    /// - Returns: An updated SSDatePicker instance.
    public func headerDateStyle(color: Color? = nil, font: Font? = nil) -> SSDatePicker {
        var picker = self
        color.map { picker.configuration.headerDateStyle.color = $0 }
        font.map { picker.configuration.headerDateStyle.font = $0 }
        return picker
    }
    
    /// Sets the style for the weekday labels in the date picker.
    /// - Parameters:
    ///   - color: The color of the weekday labels.
    ///   - font: The font of the weekday labels.
    /// - Returns: An updated SSDatePicker instance.
    public func weekdayStyle(color: Color? = nil, font: Font? = nil) -> SSDatePicker {
        var picker = self
        color.map { picker.configuration.weekdayStyle.color = $0 }
        font.map { picker.configuration.weekdayStyle.font = $0 }
        return picker
    }
    
    /// Sets the style for the date labels in the date picker.
    /// - Parameters:
    ///   - color: The color of the date labels.
    ///   - font: The font of the date labels.
    /// - Returns: An updated SSDatePicker instance.
    public func dateStyle(color: Color? = nil, font: Font? = nil) -> SSDatePicker {
        var picker = self
        color.map { picker.configuration.dateStyle.color = $0 }
        font.map { picker.configuration.dateStyle.font = $0 }
        return picker
    }
    
    /// Sets the style for the month labels in the date picker.
    /// - Parameters:
    ///   - color: The color of the month labels.
    ///   - font: The font of the month labels.
    /// - Returns: An updated SSDatePicker instance.
    public func monthStyle(color: Color? = nil, font: Font? = nil) -> SSDatePicker {
        var picker = self
        color.map { picker.configuration.monthStyle.color = $0 }
        font.map { picker.configuration.monthStyle.font = $0 }
        return picker
    }
    
    /// Sets the style for the selected month in the date picker.
    /// - Parameters:
    ///   - color: The color of the selected month.
    ///   - font: The font of the selected month.
    /// - Returns: An updated SSDatePicker instance.
    public func selectedMonthStyle(color: Color? = nil, font: Font? = nil) -> SSDatePicker {
        var picker = self
        color.map { picker.configuration.selectedMonthStyle.color = $0 }
        font.map { picker.configuration.selectedMonthStyle.font = $0 }
        return picker
    }
    
    /// Sets the style for the year labels in the date picker.
    /// - Parameters:
    ///   - color: The color of the year labels.
    ///   - font: The font of the year labels.
    /// - Returns: An updated SSDatePicker instance.
    public func yearStyle(color: Color? = nil, font: Font? = nil) -> SSDatePicker {
        var picker = self
        color.map { picker.configuration.yearStyle.color = $0 }
        font.map { picker.configuration.yearStyle.font = $0 }
        return picker
    }
    
    /// Sets the style for the selected year in the date picker.
    /// - Parameters:
    ///   - color: The color of the selected year.
    ///   - font: The font of the selected year.
    /// - Returns: An updated SSDatePicker instance.
    public func selectedYearStyle(color: Color? = nil, font: Font? = nil) -> SSDatePicker {
        var picker = self
        color.map { picker.configuration.selectedYearStyle.color = $0 }
        font.map { picker.configuration.selectedYearStyle.font = $0 }
        return picker
    }
    
    /// Sets the style for the button in the date picker.
    /// - Parameters:
    ///   - color: The color of the button.
    ///   - font: The font of the button.
    /// - Returns: An updated SSDatePicker instance.
    public func buttonStyle(color: Color? = nil, font: Font? = nil) -> SSDatePicker {
        var picker = self
        color.map { picker.configuration.buttonStyle.color = $0 }
        font.map { picker.configuration.buttonStyle.font = $0 }
        return picker
    }
    
    /// Sets the style for the current month and year label in the date picker.
    /// - Parameters:
    ///   - color: The color of the current month and year label.
    ///   - font: The font of the current month and year label.
    /// - Returns: An updated SSDatePicker instance.
    public func currentMonthYearLabelStyle(color: Color? = nil, font: Font? = nil) -> SSDatePicker {
        var picker = self
        color.map { picker.configuration.currentMonthYearLabelStyle.color = $0 }
        font.map { picker.configuration.currentMonthYearLabelStyle.font = $0 }
        return picker
    }
    
    /// Sets the color for the selected date in the date picker.
    /// - Parameters:
    ///   - backgroundColor: The background color of the selected date.
    ///   - foregroundColor: The foreground color of the selected date.
    /// - Returns: An updated SSDatePicker instance.
    public func selectedDateColor(backgroundColor: Color? = nil, foregroundColor: Color? = nil) -> SSDatePicker {
        var picker = self
        backgroundColor.map { picker.configuration.selectedDateColor.backgroundColor = $0 }
        foregroundColor.map { picker.configuration.selectedDateColor.foregroundColor = $0 }
        return picker
    }
    
    /// Sets the color for today's date in the date picker.
    /// - Parameters:
    ///   - backgroundColor: The background color of today's date.
    ///   - foregroundColor: The foreground color of today's date.
    /// - Returns: An updated SSDatePicker instance.
    public func todayColor(backgroundColor: Color? = nil, foregroundColor: Color? = nil) -> SSDatePicker {
        var picker = self
        picker.configuration.todayDateColor.backgroundColor = backgroundColor
        picker.configuration.todayDateColor.foregroundColor = foregroundColor
        return picker
    }
    
    /// Sets the color for today's date when it is selected in the date picker.
    /// - Parameters:
    ///   - backgroundColor: The background color of the selected today's date.
    ///   - foregroundColor: The foreground color of the selected today's date.
    /// - Returns: An updated SSDatePicker instance.
    public func todayDateSelectionColor(backgroundColor: Color? = nil, foregroundColor: Color? = nil) -> SSDatePicker {
        var picker = self
        picker.configuration.todayDateSelectionColor.backgroundColor = backgroundColor
        picker.configuration.todayDateSelectionColor.foregroundColor = foregroundColor
        return picker
    }
    
    /// Sets the background color for the date picker.
    /// - Parameter color: The background color of the date picker.
    /// - Returns: An updated SSDatePicker instance.
    public func pickerBackgroundColor(_ color: Color) -> SSDatePicker {
        var picker = self
        picker.configuration.pickerBackgroundColor = color
        return picker
    }
    
    /// Sets the color for the separator line between date components in the date picker.
    /// - Parameter color: The color of the separator line.
    /// - Returns: An updated SSDatePicker instance.
    public func sepratorLineColor(_ color: Color) -> SSDatePicker {
        var picker = self
        picker.configuration.sepratorLineColor = color
        return picker
    }
    
    /// Sets the overlay color for the background of the entire date picker.
    /// - Parameter color: The color of the overlay.
    /// - Returns: An updated SSDatePicker instance.
    public func popupOverlayColor(_ color: Color) -> SSDatePicker {
        var picker = self
        picker.configuration.popupOverlayColor = color
        return picker
    }
    
    /// Sets the minimum selectable date in the date picker.
    /// - Parameter date: The minimum selectable date.
    /// - Returns: An updated SSDatePicker instance.
    public func minimumDate(_ date: Date) -> SSDatePicker {
        var picker = self
        picker.configuration.minimumDate = date
        return picker
    }
    
    /// Sets the maximum selectable date in the date picker.
    /// - Parameter date: The maximum selectable date.
    /// - Returns: An updated SSDatePicker instance.
    public func maximumDate(_ date: Date) -> SSDatePicker {
        var picker = self
        picker.configuration.maximumDate = date
        return picker
    }
    
    /// Disables selection of past dates in the date picker.
    /// - Returns: An updated SSDatePicker instance.
    public func disablePastDate() -> SSDatePicker {
        var picker = self
        picker.configuration.minimumDate = Date()
        return picker
    }
    
    /// Disables selection of future dates in the date picker.
    /// - Returns: An updated SSDatePicker instance.
    public func disableFutureDate() -> SSDatePicker {
        var picker = self
        picker.configuration.maximumDate = Date()
        return picker
    }
    
    /// Sets the calendar used by the date picker.
    /// - Parameter calendar: The calendar to be used.
    /// - Returns: An updated SSDatePicker instance.
    public func calendar(_ calendar: Calendar) -> SSDatePicker {
        var picker = self
        picker.configuration.calendar = calendar
        return picker
    }
    
    /// Sets the callback closure to be executed when a date is selected in the date picker.
    /// - Parameter completion: The closure to be executed.
    /// - Returns: An updated SSDatePicker instance.
    public func onDateSelection(_ completion: @escaping (Date) -> ()) -> SSDatePicker {
        let picker = self
        picker.datePickerManager.dateSelectionCallback = completion
        return picker
    }
    
    /// The current month displayed in the date picker.
    /// Setting this property will determine the month whose calendar dates will be displayed when the picker is opened.
    public func currentMonth(_ date: Date) -> SSDatePicker {
        let picker = self
        picker.datePickerManager.currentMonth = date
        return picker
    }
    
    /// The selected date in the date picker. Set this property to pre-select a specific date.
    public func selectedDate(_ date: Date?) -> SSDatePicker {
        let picker = self
        picker.datePickerManager.selectedDate = date
        return picker
    }
    
    /// Sets the disable dates in the date picker.
    /// - Parameter dates: All dates that should be disable.
    /// - Returns: An updated SSDatePicker instance.
    public func disableDates(_ dates: [Date]) -> SSDatePicker {
        let picker = self
        picker.datePickerManager.disableDates = dates
        return picker
    }
    
    /// Enables date range selection in the date picker.
    /// - Returns: An SSDateRangePicker instance for configuring date range selection.
    public func enableDateRangeSelection() -> SSDateRangePicker {
        var picker = self
        picker.configuration.allowRangeSelection = true
        return SSDateRangePicker(picker)
    }
    
    /// Enables multiple date selection in the date picker.
    /// - Returns: An SSMultiDatePicker instance for configuring multiple date selection.
    public func enableMultipleDateSelection() -> SSMultiDatePicker {
        var picker = self
        picker.configuration.allowMultipleSelection = true
        return SSMultiDatePicker(picker)
    }
    
}
