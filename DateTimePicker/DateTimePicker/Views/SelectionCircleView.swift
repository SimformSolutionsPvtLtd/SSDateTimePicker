//
//  SelectionCircleView.swift
//  DateTimePicker
//
//  Created by Rizwana Desai on 24/11/23.
//

import SwiftUI

struct SelectionCircleView: View {
    
    var body: some View {
        Circle()
            .fill()
            .frame(width: radius, height: radius)
            .foregroundColor(.red)
//            .background(Circle().foregroundColor(Color.green))
    }
    
    var radius: CGFloat {
        SSCalendarConstants.widthForDaysOfWeek
    }
}

struct SelectionCircleView_Previews: PreviewProvider {
    static var previews: some View {
        SelectionCircleView()
    }
}
