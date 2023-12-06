//
//  PickerExampleView.swift
//  Example
//
//  Created by Rizwana Desai on 22/11/23.
//

import SwiftUI
import DateTimePicker
import Combine

struct PickerExampleView: View {
    
    //MARK: - Property
    @State var showCalender: Bool = false
    @State var showTimePicker: Bool = false
    @State var displayCustomizedCalendar: Bool = false
    @State var selectedDate: Date = Date()
    @State var selectedDateCombine: Date?
    @ObservedObject var pickerViewModel = PickerViewModel()

    //MARK: - init
    init() {
    }
    
    
    //MARK: - Body
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 20) {
                singleSelectionView
                Divider()
                multipleSelectionView
                Divider()
                rangeSelectionView
                Divider()
                timePickerView
                Spacer()
            }
            .padding(20)
            SSDatePicker(showCalender: $showCalender, calendarManager: ObservedObject(wrappedValue: pickerViewModel.datePickerManager))
            SSTimePicker(showTimePicker: $showTimePicker, timePickerManager: pickerViewModel.timePickerManager)
        }
        
    }
    
    //MARK: - Sub views
    
    var singleSelectionView: some View {
        HStack {
            btnSelectSingleDate
            Text(pickerViewModel.selectedDate?.monthDateYear ?? "-")
        }
    }
    
    var multipleSelectionView: some View {
       VStack {
            btnSelectMultipleDates
            if let dates = pickerViewModel.selectedDates {
                ForEach(0..<dates.count, id: \.self) { index in
                    Text(dates[index].monthDateYear)
                }
            }
        }
    }
    
    var rangeSelectionView: some View {
        VStack(alignment: .leading) {
            btnSelectDateRange
            Text("Start Date: \(pickerViewModel.startDate?.monthDateYear ?? "-")")
            Text("End Date: \(pickerViewModel.endDate?.monthDateYear ?? "-")")
        }
    }
    
    var btnSelectDateRange: some View {
        Button {
            pickerViewModel.configureForDateRangeSelection()
            showCalender.toggle()
        } label: {
            Text("Select Date range: Start Date & end Date")
        }
    }
    
    var timePickerView: some View {
        VStack {
            btnTimePicker
            Text("Selected Time: \(pickerViewModel.selectedTime?.timeOnlyWithPadding ?? "")")
        }
    }
    
    var btnTimePicker: some View {
        Button {
            showTimePicker.toggle()
        } label: {
            Text("Time picker")
        }

    }
    
    var btnSelectSingleDate: some View {
        Button {
            pickerViewModel.configureForSingleDateSelection()
            showCalender.toggle()
        } label: {
            Text("Single Selection Picker")
        }
    }
    
    var btnSelectMultipleDates: some View {
        Button {
            pickerViewModel.configureForMultipleDateSelection()
            showCalender.toggle()
        } label: {
            Text("Multiple selection Picker")
        }
    }
    
    
}

extension PickerExampleView: DatePickerDataSource {
    
    func datePicker(canSelectDate date: Date) -> Bool {
        let day = Calendar.current.dateComponents([.day], from: date).day!
        return day != 4
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PickerExampleView()
    }
}
