//
//  SSTimePickerManager.swift
//  DateTimePicker
//
//  Created by Rizwana Desai on 04/12/23.
//

import Foundation


public final class SSTimePickerManager: ObservableObject {
    
    //MARK: - Property
    
    @Published var selectedTimeFromat: TimeFormat = .am
    @Published public var selectedTime: Date?
    @Published var hourSelected: String = "12"
    @Published var minutesSelected: String = "00"
    public var configuration: SSTimePickerConfiguration
    public weak var delegate: SSTimePickerDelegate?

    // Clock's angle and current clock view
    @Published var angle: Double = 0
    @Published var isMinuteClock: Bool = false
        
    //MARK: - init
    
    public init(configuration: SSTimePickerConfiguration) {
        self.configuration = configuration
    }
    
    //MARK: - Methods
    
    func actionShowHourClock() {
        updateCurrentHourAngle()
        isMinuteClock = false
    }
   
    func actionShowMinuteClock() {
        updateCurrentMinuteAngle()
        isMinuteClock = true
    }
    
    func updateCurrentHourAngle() {
        angle = Double((Int(hourSelected) ?? 12) * 30)
    }
    
    func updateCurrentMinuteAngle() {
        angle = Double((Int(minutesSelected) ?? 00) * 6)
    }
    
    func updateSelectedTime() {
        let format = DateFormatter.dateFormatter(DateFormat.twentyFourHourFormat)
        // get hours for 24-hrs format
        let hour = (Int(hourSelected) ?? 12)
        let updatedHour = selectedTimeFromat == .am ? (hour == 12 ? 00.formattedTime : hour.formattedTime) : "\(hour < 12 ? (hour + 12).formattedTime : hour.formattedTime)"
        let date = format.date(from: "\(updatedHour):\(minutesSelected)")
        selectedTime = date
        notifyDelegate()
        isMinuteClock = false
    }
    
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
    
    func notifyDelegate() {
        if let selectedTime {
            self.delegate?.timePicker(didSelectTime: selectedTime)
        }
    }
    
}

enum TimeFormat {
    case am
    case pm
}
