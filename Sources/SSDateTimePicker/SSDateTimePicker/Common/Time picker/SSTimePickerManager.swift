//
//  SSTimePickerManager.swift
//  DateTimePicker
//
//  Created by Rizwana Desai on 04/12/23.
//

import Foundation

/// A manager class for handling the state and behavior of the SSTimePicker.
final class SSTimePickerManager: ObservableObject {
    
    // MARK: - Properties

    /// The configuration for the SSTimePicker.
    var configuration: SSTimePickerConfiguration
    
    /// The selected time. Set this property to pre-select a specific time.
    @Published var selectedTime: Date?
        
    /// The selected time format (AM or PM).
    @Published var selectedTimeFromat: TimeFormat = .am
    
    /// The selected hour as a string.
    @Published var hourSelected: String = "12"
    
    /// The selected minutes as a string.
    @Published var minutesSelected: String = "00"
    
    /// The angle representing the current position of the clock hand.
    @Published var angle: Double = 0
    
    /// A flag indicating whether the minute clock view is currently active.
    @Published var isMinuteClock: Bool = false

    var timeSelectionCallback: (Date) -> () = {_ in}

    // MARK: - Initializer

    /// Initializes the SSTimePickerManager with the provided configuration.
    ///
    /// - Parameter configuration: The style configuration for the SSTimePicker.
    public init(configuration: SSTimePickerConfiguration = SSTimePickerConfiguration()) {
        self.configuration = configuration
    }
    
    //MARK: - Methods
    
    /// Switches the time picker to show the hour clock view and updates the current hour angle.
    func actionShowHourClock() {
        updateCurrentHourAngle()
        isMinuteClock = false
    }
    
    /// Switches the time picker to show the minute clock view and updates the current minute angle.
    func actionShowMinuteClock() {
        updateCurrentMinuteAngle()
        isMinuteClock = true
    }
    
    /// Updates the angle based on the current selected hour.
    func updateCurrentHourAngle() {
        let hour = updateWithDefaultHourIfEmpty()
        angle = Double(hour * 30)
    }
    
    /// Updates the angle based on the current selected minute.
    func updateCurrentMinuteAngle() {
        let minute = updateWithDefaultMinuteIfEmpty()
        angle = Double(minute * 6)
    }
    
    /// Updates the selected time based on the current hour, minute, and time format.
    func updateSelectedTime() {
        _ = updateWithDefaultMinuteIfEmpty()
        _ = updateWithDefaultHourIfEmpty()
        let format = DateFormatter.configure(with: DateFormat.twentyFourHourFormat)
        // get hours for 24-hrs format
        let hour = (Int(hourSelected) ?? 12)
        let updatedHour = selectedTimeFromat == .am ? (hour == 12 ? 00.formattedTime : hour.formattedTime) : "\(hour < 12 ? (hour + 12).formattedTime : hour.formattedTime)"
        let date = format.date(from: "\(updatedHour):\(minutesSelected)")
        selectedTime = date
        handleCallback()
        isMinuteClock = false
    }

    // In case if textfield is empty set default minute
    func updateWithDefaultMinuteIfEmpty() -> Int {
        let minute = Int(minutesSelected) ?? 00
        if minutesSelected == "" {
            minutesSelected = "00"
        }
        return minute
    }

    // In case if textfield is empty set default hour
    func updateWithDefaultHourIfEmpty() -> Int {
        let hour = Int(hourSelected) ?? 12
        if hourSelected == "" {
            hourSelected = "12"
        }
        return hour
    }

    /// Sets up the initial time, angle, and clock view based on the selected time.
    func setUpTimeAndAngle() {
        let calender = Calendar.current
        guard let selectedTime else { return }
        // 24 Hrs
        var hourTemp = calender.component(.hour, from: selectedTime)
        selectedTimeFromat = hourTemp <= 12 ? .am : .pm
        hourTemp = hourTemp == 0 ? 12 : hourTemp
        hourTemp = hourTemp <= 12 ? hourTemp: hourTemp - 12
        let minutesTemp = calender.component(.minute, from: selectedTime)
        hourSelected = hourTemp.formattedTime
        minutesSelected = minutesTemp.formattedTime
        updateCurrentHourAngle()
    }
    
    /// Notifies the delegate when a time is selected.
    func handleCallback() {
        if let selectedTime {
            timeSelectionCallback(selectedTime)
        }
    }
    
}
