//
//  SSTimePickerManager.swift
//  DateTimePicker
//
//  Created by Rizwana Desai on 04/12/23.
//

import Foundation


public class SSTimePickerManager: ObservableObject {
    
    //MARK: - Property
    
    public var configuration: SSTimePickerConfiguration
    @Published var selectedTimeFromat: TimeFormat = .am
    @Published public var selectedTime: Date? = Date()
    @Published var hour: String = "12"
    @Published var minutes: String = "0"
    
    // Clock's angle and current clock view
    @Published var angle: Double = 0
    @Published var isMinuteClock: Bool = false
    
    @Published public var onTimeSelection = Event<Date?>()
    
    //MARK: - init
    
    public init(configuration: SSTimePickerConfiguration) {
        self.configuration = configuration
    }
    
    //MARK: - Methods
    
    func actionShowHourClock() {
        angle = Double((Int(hour) ?? 1) * 30)
        isMinuteClock = false
    }
    
    func actionShowMinuteClock() {
        angle = Double((Int(minutes) ?? 1) * 6)
        isMinuteClock = false
    }
    
    func updateSelectedTime() {
        let format = DateFormatter.dateFormatter(DateFormat.twentyFourHourFormat)
        // get hours for 24-hrs format
        let updatedHour = selectedTimeFromat == .am ? hour : "\((Int(hour) ?? 0) + 12)"
        let date = format.date(from: "\(updatedHour):\(minutes)")
        selectedTime = date
        onTimeSelection.send(selectedTime)
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
        hour = "\(hourTemp)"
        minutes = "\(minutesTemp)"
        angle = Double(hourTemp*30)
    }
    
}

enum TimeFormat {
    case am
    case pm
}
