//
//  PickerExampleView.swift
//  Example
//
//  Created by Rizwana Desai on 22/11/23.
//

import SwiftUI
import SSDateTimePicker
import Combine

struct PickerExampleView: View {
    
    //MARK: - Property
    @State var showCalender: Bool = false
    @State var showTimePicker: Bool = false
    @State var displayCustomizedCalendar: Bool = false
    @State var selectedDate: Date = Date()
    @State var selectedDateCombine: Date?
    @ObservedObject var pickerViewModel = PickerViewModel()
    
//    //MARK: - Initializer
//
//    init() {
//
//    }
    
    //MARK: - Body
    var body: some View {
        ZStack {
            dateTimePickerExampleView
            
            // Date Picker
            SSDatePicker(showCalender: $showCalender, calendarManager: ObservedObject(wrappedValue: pickerViewModel.datePickerManager))
            
            // Time Picker
            SSTimePicker(showTimePicker: $showTimePicker, timePickerManager: pickerViewModel.timePickerManager)
        }
        
    }
    
    //MARK: - Sub views
    
    var dateTimePickerExampleView: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                singleSelectionView
                Divider()
                multipleSelectionView
                Divider()
                rangeSelectionView
                Divider()
                btnCustomizedPicker
                Divider()
                timePickerView
                Spacer()
            }
            .padding(20)
        }
    }
    
    var singleSelectionView: some View {
        VStack(alignment: .leading) {
            btnSelectSingleDate
            Text(pickerViewModel.selectedDate?.monthDateYear ?? "")
        }
    }
    
    var multipleSelectionView: some View {
        VStack(alignment: .leading) {
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
            Text("\(LocalizedString.startDate) \(pickerViewModel.startDate?.monthDateYear ?? "")")
            Text("\(LocalizedString.endDate) \(pickerViewModel.endDate?.monthDateYear ?? "")")
        }
    }
    
    var btnSelectDateRange: some View {
        Button {
            pickerViewModel.configureForDateRangeSelection()
            showCalender.toggle()
        } label: {
            Text(LocalizedString.dateRangeSelectionPicker)
                .themeButton()
        }
    }
    
    var timePickerView: some View {
        VStack(alignment: .leading) {
            btnTimePicker
            Text("\(LocalizedString.selectedTime) \(pickerViewModel.selectedTime?.timeOnlyWithPadding ?? "")")
        }
    }
    
    var btnTimePicker: some View {
        Button {
            showTimePicker.toggle()
        } label: {
            Text(LocalizedString.timePicker)
                .themeButton()
        }
        
    }
    
    var btnSelectSingleDate: some View {
        Button {
            pickerViewModel.configureForSingleDateSelection()
            showCalender.toggle()
        } label: {
            Text(LocalizedString.singleDateSelectionPicker)
                .themeButton()
        }
    }
    
    var btnCustomizedPicker: some View {
        Button {
            pickerViewModel.customizedDatePicker()
            showCalender.toggle()
        } label: {
            Text(LocalizedString.customizedDatePicker)
                .themeButton()
        }
    }
    
    var btnSelectMultipleDates: some View {
        Button {
            pickerViewModel.configureForMultipleDateSelection()
            showCalender.toggle()
        } label: {
            Text(LocalizedString.multipleDateSelectionPicker)
                .themeButton()
            
        }
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PickerExampleView()
    }
}
