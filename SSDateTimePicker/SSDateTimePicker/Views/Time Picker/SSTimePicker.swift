//
//  SSTimePicker.swift
//  DateTimePicker
//
//  Created by Rizwana Desai on 04/12/23.
//

import SwiftUI

public struct SSTimePicker: View, TimePickerConfigurationDirectAccess {
    
    // MARK: - Properties
    
    @ObservedObject var timePickerManager: SSTimePickerManager = SSTimePickerManager()
    @Binding var showTimePicker: Bool
    @State var isInEditMode: Bool = false
    
    var configuration: SSTimePickerConfiguration {
        get {
            timePickerManager.configuration
        } set {
            timePickerManager.configuration = newValue
        }
    }
    
    //MARK: - Initializer
    
    public init(showTimePicker: Binding<Bool>) {
        self._showTimePicker = showTimePicker
    }
    
    //MARK: - Body
    
    public var body: some View {
        ZStack(alignment: .center) {
            if showTimePicker {
                popupOverlayColor
                    .ignoresSafeArea()
                    .onTapGesture {
                        actionCancel()
                    }
                timePickerSubview
                    .background(pickerBackgroundColor)
                    .cornerRadius(pickerViewRadius)
                    .padding(.leading, SSPickerConstants.pickerLeadingTrailing)
                    .padding(.trailing, SSPickerConstants.pickerLeadingTrailing)
                    .compositingGroup()
            }
        }
        .onChange(of: showTimePicker) { newValue in
            if showTimePicker {
                timePickerManager.setUpTimeAndAngle()
            }
        }
    }
    
    //MARK: - Sub views
    
    private var timePickerSubview: some View {
        VStack(alignment: .leading, spacing: SSPickerConstants.verticleSpacingTen) {
            timePickerHeader
            SSClockPicker(timePickerManager: timePickerManager)
            bottomButtons
        }
        .padding(SSPickerConstants.pickerViewInnerPadding)
    }
    
    private var timePickerHeader: some View {
        VStack(alignment: .leading, spacing: SSPickerConstants.verticleSpacingTen) {
            lblSelectedDate
            Divider()
        }
    }
    
    private var lblSelectedDate: some View {
        VStack(alignment: .leading, spacing: SSPickerConstants.verticleSpacingTen) {
            Text(LocalizedString.selectTime)
                .font(headerTitleFont)
                .foregroundColor(headerTitleColor)
            textFieldHourMinutes
        }
        .padding(SSPickerConstants.paddingTen)
    }
    
    private var textFieldHourMinutes: some View {
        HStack(spacing: 4) {
            SSTimeTextField(time: $timePickerManager.hourSelected, configuration: configuration, isHourField: true, isInEditMode: $isInEditMode)
                .simultaneousGesture(TapGesture().onEnded {
                    timePickerManager.actionShowHourClock()
                })
            Text(":")
                .font(timeLabelFont)
                .foregroundColor(timeLabelForegroundColor)
            SSTimeTextField(time: $timePickerManager.minutesSelected, configuration: configuration, isHourField: false, isInEditMode: $isInEditMode)
                .simultaneousGesture(TapGesture().onEnded {
                    timePickerManager.actionShowMinuteClock()
                })
            amPMView
                .padding(2)
            Spacer()
        }
        .toolbar {
            ToolbarItem(placement: .keyboard) {
                HStack {
                    Spacer()
                    Button(LocalizedString.done) {
                        actionDone()
                    }
                }
            }
        }
    }
    
    private var amPMView: some View {
        VStack {
            btnAM
            btnPM
        }
    }
    
    private var btnAM: some View {
        Button {
            withAnimation {
                timePickerManager.selectedTimeFromat = .am
            }
        } label: {
            labelTimeFormat(LocalizedString.am, isSelected: timePickerManager.selectedTimeFromat == .am)
        }
    }
    
    private var btnPM: some View {
        Button {
            withAnimation {
                timePickerManager.selectedTimeFromat = .pm
            }
        } label: {
            labelTimeFormat(LocalizedString.pm, isSelected: timePickerManager.selectedTimeFromat == .pm)
        }
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
                .themeButton(buttonsForegroundColor, buttonFont)
        }
    }
    
    private var btnOk: some View {
        Button {
            withAnimation {
                self.actionOk()
            }
        } label: {
            Text(LocalizedString.ok)
                .themeButton(buttonsForegroundColor, buttonFont)
        }
    }
    
    private func labelTimeFormat(_ format: String, isSelected: Bool) -> some View {
        Text(format)
            .font(isSelected ? selectedTimeFormatFont : timeFormatFont)
            .foregroundColor(isSelected ? timeFormatSelectionColor : timeFormatColor)
            .transition(.scale)
            .animation(.easeIn, value: isSelected)
    }
    
}

extension SSTimePicker {
    
    //MARK: - Methods
    
    func actionCancel() {
        if timePickerManager.isMinuteClock {
            timePickerManager.isMinuteClock = false
        } else {
            showTimePicker.toggle()
        }
    }
    
    func actionOk() {
        timePickerManager.updateSelectedTime()
        showTimePicker.toggle()
    }
    
    func actionDone() {
        isInEditMode = false
        if timePickerManager.isMinuteClock {
            timePickerManager.updateCurrentMinuteAngle()
        } else {
            timePickerManager.updateCurrentHourAngle()
        }
    }
    
}

// MARK: - Modifiers

extension SSTimePicker {
    
    /// Set the selected time for the time picker.
    /// - Parameter time: The selected time.
    /// - Returns: The modified SSTimePicker instance.
    public func selectedTime(_ time: Time?) -> SSTimePicker {
        let picker = self
        picker.timePickerManager.selectedTime = time
        return picker
    }
    
    /// Apply a custom theme to the time picker.
    /// - Parameters:
    ///   - pickerBackgroundColor: Background color of the time picker.
    ///   - primaryColor: Primary color used for various elements.
    ///   - timeLabelBackgroundColor: Background color for the time label.
    /// - Returns: The modified SSTimePicker instance.
    public func themeColor(pickerBackgroundColor: Color, primaryColor: Color, timeLabelBackgroundColor: Color) -> SSTimePicker {
        var picker = self
        picker.configuration.timeLabelStyle.color = primaryColor
        picker.configuration.selectedTimeFormatStyle.color = primaryColor
        picker.configuration.buttonStyle.color = primaryColor
        picker.configuration.clockHandColor = primaryColor
        picker.configuration.pickerBackgroundColor = pickerBackgroundColor
        picker.configuration.timeLabelBackgroundColor = timeLabelBackgroundColor
        return picker
    }
    
    /// Customize the style of the header title.
    /// - Parameters:
    ///   - color: Text color of the header title.
    ///   - font: Font of the header title.
    /// - Returns: The modified SSTimePicker instance.
    public func headerTitleStyle(color: Color? = nil, font: Font? = nil) -> SSTimePicker {
        var picker = self
        color.map { picker.configuration.headerTitleStyle.color = $0 }
        font.map { picker.configuration.headerTitleStyle.font = $0 }
        return picker
    }
    
    /// Customize the style of the time label.
    /// - Parameters:
    ///   - color: Text color of the time label.
    ///   - font: Font of the time label.
    /// - Returns: The modified SSTimePicker instance.
    public func timeLabelStyle(color: Color? = nil, font: Font? = nil) -> SSTimePicker {
        var picker = self
        color.map { picker.configuration.timeLabelStyle.color = $0 }
        font.map { picker.configuration.timeLabelStyle.font = $0 }
        return picker
    }
    
    /// Customize the style of the time format(AM/PM).
    /// - Parameters:
    ///   - color: Text color of the time format.
    ///   - font: Font of the time format.
    /// - Returns: The modified SSTimePicker instance.
    public func timeFormatStyle(color: Color? = nil, font: Font? = nil) -> SSTimePicker {
        var picker = self
        color.map { picker.configuration.timeFormatStyle.color = $0 }
        font.map { picker.configuration.timeFormatStyle.font = $0 }
        return picker
    }
    
    /// Customize the style of the clock numbers.
    /// - Parameters:
    ///   - color: Text color of the clock numbers.
    ///   - font: Font of the clock numbers.
    /// - Returns: The modified SSTimePicker instance.
    public func clockNumberStyle(color: Color? = nil, font: Font? = nil) -> SSTimePicker {
        var picker = self
        color.map { picker.configuration.clockNumberStyle.color = $0 }
        font.map { picker.configuration.clockNumberStyle.font = $0 }
        return picker
    }
    
    /// Customize the style of the buttons.
    /// - Parameters:
    ///   - color: Text color of the buttons.
    ///   - font: Font of the buttons.
    /// - Returns: The modified SSTimePicker instance.
    public func buttonStyle(color: Color? = nil, font: Font? = nil) -> SSTimePicker {
        var picker = self
        color.map { picker.configuration.buttonStyle.color = $0 }
        font.map { picker.configuration.buttonStyle.font = $0 }
        return picker
    }
    
    /// Customize the style of the selected time format.
    /// - Parameters:
    ///   - color: Text color of the selected time format.
    ///   - font: Font of the selected time format.
    /// - Returns: The modified SSTimePicker instance.
    public func selectedTimeFormatStyle(color: Color? = nil, font: Font? = nil) -> SSTimePicker {
        var picker = self
        color.map { picker.configuration.selectedTimeFormatStyle.color = $0 }
        font.map { picker.configuration.selectedTimeFormatStyle.font = $0 }
        return picker
    }
    
    /// Set a callback closure to be executed when a time is selected.
    /// - Parameter completion: A closure to be called with the selected time.
    /// - Returns: The modified SSTimePicker instance.
    public func onTimeSelection(_ completion: @escaping (Date) -> ()) -> SSTimePicker {
        let picker = self
        picker.timePickerManager.timeSelectionCallback = completion
        return picker
    }
    
}

