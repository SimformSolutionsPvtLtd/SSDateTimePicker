//
//  SSCustomWheelPicker.swift
//  DateTimePicker
//
//  Created by Rizwana Desai on 04/12/23.
//

import SwiftUI

struct SSCustomWheelPicker: View {
   
    var body: some View {
        wheelPicker
            .frame(height: 200)
    }
    
    var wheelPicker: some View {
        ScrollView() {
            VStack {
                ForEach(0..<60, id: \.self) { time in
                    Text("\(time)")
                }
            }
        }
        .frame(height: 100)
    }
    
}

struct SSCustomWheelPicker_Previews: PreviewProvider {
    static var previews: some View {
        SSCustomWheelPicker()
    }
}
