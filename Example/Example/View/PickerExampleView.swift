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
    
    var headerView: some View {
        Text(LocalizedString.dateTimePickerExample)
            .font(.system(size: 22, weight: .bold))
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, maxHeight: 60)
            .background(Color.darkPink.ignoresSafeArea())
    }
    
    var dateTimePickerExampleView: some View {
        VStack {
            headerView
            ScrollView {
                VStack(alignment: .center, spacing: 10) {
                    singleSelectionView
                    multipleSelectionView
                    rangeSelectionView
                    btnCustomizedPicker
                    timePickerView
                }
            }
        }
    }
    
    var singleSelectionView: some View {
        VStack {
            btnSelectSingleDate
            Text("\(LocalizedString.selectedDate)  \(pickerViewModel.selectedDate?.monthDateYear ?? "")")
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
        VStack {
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
        VStack {
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
