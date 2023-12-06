//
//  SSTimeTextField.swift
//  DateTimePicker
//
//  Created by Rizwana Desai on 04/12/23.
//

import SwiftUI

struct SSTimeTextField: View {
    
    //MARK: - Property
    
    @Binding var time: String
    var placeHolder: String
    var backgroundColor: Color
    var foregrondColor: Color
    private let charLimit = 2
    
    //MARK: - Body
    
    var body: some View {
        timeLabel
    }
    
    //MARK: - Sub views
    
    var timeLabel: some View {
        Text(time.count == 1 ? "0\(time)" : time)
            .keyboardType(.numberPad)
            .multilineTextAlignment(.center)
            .font(.system(size: 20, weight: .semibold))
            .padding(SSPickerConstants.timeFieldPadding)
            .foregroundColor(foregrondColor)
            .background(backgroundColor)
            .fixedSize()
            .cornerRadius(SSPickerConstants.timeFieldCornerRadius)
            .onChange(of: time) { newValue in
                if time.count > charLimit {
                    time = String(time.prefix(charLimit))
                }
            }
    }
    
    var txtField: some View {
        TextField(placeHolder, text: $time)
            .keyboardType(.numberPad)
            .multilineTextAlignment(.center)
            .font(.system(size: 20, weight: .semibold))
            .padding(SSPickerConstants.timeFieldPadding)
            .foregroundColor(foregrondColor)
            .background(backgroundColor)
            .fixedSize()
            .cornerRadius(SSPickerConstants.timeFieldCornerRadius)
            .onChange(of: time) { newValue in
                if time.count > charLimit {
                    time = String(time.prefix(charLimit))
                }
            }
    }
    
}

struct SSTimeTextField_Previews: PreviewProvider {
    static var previews: some View {
        SSTimeTextField(time: .constant("12"), placeHolder: "HH", backgroundColor: Color.peach, foregrondColor: Color.darkPink)
    }
}
