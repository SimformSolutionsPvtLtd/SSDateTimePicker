//
//  SSTimePicker.swift
//  DateTimePicker
//
//  Created by Rizwana Desai on 04/12/23.
//

import SwiftUI

public struct SSTimePicker: View, TimePickerConfigurationDirectAccess {
    
    //MARK: - Property
    
    @ObservedObject var timePickerManager: SSTimePickerManager
    @Binding var showTimePicker: Bool
    
    var configuration: SSTimePickerConfiguration {
        timePickerManager.configuration
    }
    
    //MARK: - init
    
    public init(showTimePicker: Binding<Bool>, timePickerManager: SSTimePickerManager) {
        self._showTimePicker = showTimePicker
        self.timePickerManager = timePickerManager
    }
    
    //MARK: - Body
    
    public var body: some View {
        ZStack(alignment: .center) {
            if showTimePicker {
                popupOverlayColor
                    .ignoresSafeArea()
                timePickerSubview
                    .background(pickerBackgroundColor)
                    .cornerRadius(pickerViewRadius)
                    .padding(.leading, SSPickerConstants.pickerLeadingTrailing)
                    .padding(.trailing, SSPickerConstants.pickerLeadingTrailing)
                    .compositingGroup()
            }
        }
    }
    
    //MARK: - Sub views
    
    var timePickerSubview: some View {
        VStack(alignment: .leading, spacing: SSPickerConstants.verticleSpacingTen) {
            timePickerHeader
            SSClockPicker(timePickerManager: timePickerManager)
            bottomButtons
        }
    }
    
    var timePickerHeader: some View {
        VStack(alignment: .leading, spacing: SSPickerConstants.verticleSpacingTen) {
            lblSelectedDate
            Divider()
        }
    }
    
    var lblSelectedDate: some View {
        VStack(alignment: .leading, spacing: SSPickerConstants.verticleSpacingTen) {
            Text("Select Time")
                .font(.system(size: 12, weight: .bold))
                .foregroundColor(headerTitleCoor)
            textFieldHourMinutes
        }
        .padding(SSPickerConstants.paddingTen)
    }
    
    var textFieldHourMinutes: some View {
        HStack(spacing: 4) {
            SSTimeTextField(time: $timePickerManager.hour, placeHolder: "HH", backgroundColor: timeTextBackgroundColor, foregrondColor: timeForegroundColor)
                .onTapGesture {
                    timePickerManager.actionShowHourClock()
                }
            Text(":")
            SSTimeTextField(time: $timePickerManager.minutes, placeHolder: "MM", backgroundColor: timeTextBackgroundColor, foregrondColor: timeForegroundColor)
                .onTapGesture {
                    timePickerManager.actionShowMinuteClock()
                }
            amPMView
            Spacer()
        }
    }
    
    var amPMView: some View {
        VStack {
            btnAM
            btnPM
        }
    }
    
    var btnAM: some View {
        Button {
            timePickerManager.selectedTimeFromat = .am
        } label: {
            labelTimeFormat("AM", isSelected: timePickerManager.selectedTimeFromat == .am)
        }
    }
    
    var btnPM: some View {
        Button {
            timePickerManager.selectedTimeFromat = .pm
        } label: {
            labelTimeFormat("PM", isSelected: timePickerManager.selectedTimeFromat == .pm)
        }
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
                .themeButton(configuration.buttonsForegroundColor)
        }
    }
    
    var btnOk: some View {
        Button {
            self.actionOk()
        } label: {
            Text("Ok")
                .themeButton(configuration.buttonsForegroundColor)
        }
    }
    
    func labelTimeFormat(_ format: String, isSelected: Bool) -> some View {
        Text(format)
            .font(.system(size: isSelected ? 15 : 12, weight: .bold))
            .foregroundColor(isSelected ? configuration.timeFormatSelectionColor : configuration.timeFormatColor)
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
    
}

struct SSTimePicker_Previews: PreviewProvider {
    static var previews: some View {
        SSTimePicker(showTimePicker: .constant(true), timePickerManager: SSTimePickerManager(configuration: SSTimePickerConfiguration()))
    }
}
