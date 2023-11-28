//
//  ContentView.swift
//  Example
//
//  Created by Rizwana Desai on 22/11/23.
//

import SwiftUI
import DateTimePicker

struct ContentView: View {
    
    //MARK: - Property
    @State var showCalender: Bool = false
    @State var displayCustomizedCalendar: Bool = false

    init() {

    }
    
    //MARK: - Body
    var body: some View {
        ZStack {
            VStack(spacing: 30) {
                btnSelectDate
                HStack {
                    btnThemePicker
//                    Text(calendarManager.selectedDate?.monthDateYear ?? "-")
                }
            }
            SSCalederView(showCalender: $displayCustomizedCalendar, calendarManager: customizedCalendar())

            SSCalederView(showCalender: $showCalender, calendarManager: calendar())
        }
       
    }
    
    //MARK: - Sub views
    
    var btnSelectDate: some View {
        Button {
            showCalender.toggle()
        } label: {
            Text("Select Date")
        }
    }
    
    var btnThemePicker: some View {
        Button {
            displayCustomizedCalendar.toggle()
        } label: {
            Text("Configured Date Picker")
        }
    }
    
    func calendar() -> StateObject<SSCalendarManager> {
        let calendarManager = SSCalendarManager(currentMonth: Date())
        return StateObject(wrappedValue: calendarManager)
    }
    
    func customizedCalendar() -> StateObject<SSCalendarManager> {
        let configuration = SSCalendarConfiguration(pickerBackgroundColor: Color(uiColor: UIColor(red: 209, green: 128, blue: 128, alpha: 1)), selectionColor: .red)
        let calendarManager = SSCalendarManager(currentMonth: Date(), configuration: configuration)
        return StateObject(wrappedValue: calendarManager)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
