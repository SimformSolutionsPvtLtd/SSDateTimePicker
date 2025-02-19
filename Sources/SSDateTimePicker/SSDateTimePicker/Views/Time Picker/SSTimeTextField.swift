//
//  SSTimeTextField.swift
//  DateTimePicker
//
//  Created by Rizwana Desai on 04/12/23.
//

import SwiftUI

struct SSTimeTextField: View, TimePickerConfigurationDirectAccess {
    
    // MARK: - Properties

    @Binding var time: String
    var configuration: SSTimePickerConfiguration
    @State var isHourField: Bool
    @Binding var isInEditMode: Bool
    private let charLimit = 2
    @FocusState private var isFocused: Bool
    
    //MARK: - Body
    
    var body: some View {
        Group {
            if isInEditMode {
                txtField
            } else {
                timeLabel
                    .gesture(TapGesture(count: 2).onEnded {
                        isInEditMode = true
                    })
            }
        }
        .onChange(of: isInEditMode) { newValue in
            isFocused = newValue
        }
    }
    
    //MARK: - Sub views
    
    private var timeLabel: some View {
        Text(time.count == 1 ? "0\(time)" : time)
            .multilineTextAlignment(.center)
            .font(timeLabelFont)
            .padding(SSPickerConstants.timeFieldPadding)
            .foregroundColor(timeLabelForegroundColor)
            .background(timeLabelBackgroundColor)
            .fixedSize()
            .cornerRadius(SSPickerConstants.timeFieldCornerRadius)
    }
    
    private var txtField: some View {
        TextField(isHourField ? SSLocalizedString.hour : SSLocalizedString.minute, text: $time)
            .focused($isFocused)
            .keyboardType(.numberPad)
            .multilineTextAlignment(.center)
            .font(timeLabelFont)
            .padding(SSPickerConstants.timeFieldPadding)
            .foregroundColor(timeLabelForegroundColor)
            .background(timeLabelBackgroundColor)
            .fixedSize()
            .cornerRadius(SSPickerConstants.timeFieldCornerRadius)
            .onChange(of: time) { [time] newTime in
                if Int(newTime) ?? 00 > (isHourField ? 12 : 59) {
                    self.time = time
                }
                if self.time.count > charLimit {
                    self.time = String(time.prefix(charLimit))
                    self.time = String(time.prefix(charLimit))
                }
            }
    }
    
}
