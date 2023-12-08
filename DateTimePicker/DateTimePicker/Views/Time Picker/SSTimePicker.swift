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
    @State var isInEditMode: Bool = false
    
    var configuration: SSTimePickerConfiguration {
        timePickerManager.configuration
    }
    
    //MARK: - Initializer
    
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
        .onChange(of: showTimePicker) { newValue in
            if showTimePicker {
                timePickerManager.setUpTimeAndAngle()
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
                .font(headerTitleFont)
                .foregroundColor(headerTitleCoor)
            textFieldHourMinutes
        }
        .padding(SSPickerConstants.paddingTen)
    }
    
    var textFieldHourMinutes: some View {
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
                    Button("Done") {
                        actionDone()
                    }
                }
               
            }
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
            withAnimation {
                timePickerManager.selectedTimeFromat = .am
            }
        } label: {
            labelTimeFormat("AM", isSelected: timePickerManager.selectedTimeFromat == .am)
        }
    }
    
    var btnPM: some View {
        Button {
            withAnimation {
                timePickerManager.selectedTimeFromat = .pm
            }
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
                .themeButton(buttonsForegroundColor, buttonFont)
        }
    }
    
    var btnOk: some View {
        Button {
            self.actionOk()
        } label: {
            Text("Ok")
                .themeButton(buttonsForegroundColor, buttonFont)
        }
    }
    
    func labelTimeFormat(_ format: String, isSelected: Bool) -> some View {
        Text(format)
            .font( isSelected ? selectedTimeFormatFont : timeFormatFont)
            .foregroundColor(isSelected ? timeFormatSelectionColor : timeFormatColor)
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

struct SSTimePicker_Previews: PreviewProvider {
    static var previews: some View {
        SSTimePicker(showTimePicker: .constant(true), timePickerManager: SSTimePickerManager(configuration: SSTimePickerConfiguration()))
    }
}
