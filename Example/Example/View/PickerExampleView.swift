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
                    singleDateSelectionView
                    multipleDateSelectionView
                    dateRangeSelectionView
                    timePickerView
                }
            }
        }
    }
    
    var singleDateSelectionView: some View {
        VStack(spacing: 10) {
            Text("\(LocalizedString.singleDateSelectionExample)")
                .font(.callout)
            Text("\(LocalizedString.selectedDate)  \(pickerViewModel.selectedDate?.monthDateYear ?? "-")")
                .font(.footnote)
            btnSelectSingleDate
        }
        .themeCard()
    }
    
    var multipleDateSelectionView: some View {
        VStack(spacing: 10) {
            Text("\(LocalizedString.multipleDateSelectionExample)")
                .font(.callout)
            Text("\(LocalizedString.selectedDates) \(pickerViewModel.getSelectedDates() ?? "-")")
                .font(.footnote)
            btnSelectMultipleDates
        }
        .themeCard()
    }
    
    var dateRangeSelectionView: some View {
        VStack(spacing: 10) {
            Text("\(LocalizedString.dateRangeSelectionExample)")
                .font(.callout)
            Text("\(LocalizedString.startDate) \(pickerViewModel.startDate?.monthDateYear ?? "-"),  \(LocalizedString.endDate) \(pickerViewModel.endDate?.monthDateYear ?? "-")")
                .font(.footnote)
            btnSelectDateRange
        }
        .themeCard()
    }
    
    var btnSelectDateRange: some View {
        Button {
            pickerViewModel.configureForDateRangeSelection()
            showCalender.toggle()
        } label: {
            Text(LocalizedString.selectDateRange)
                .themeButton()
        }
    }
    
    var timePickerView: some View {
        VStack(spacing: 10) {
            Text("\(LocalizedString.timePickerExample)")
                .font(.callout)
            Text("\(LocalizedString.selectedTime) \(pickerViewModel.selectedTime?.timeOnlyWithPadding ?? "-")")
                .font(.footnote)
            btnTimePicker
        }
        .themeCard()
    }
    
    var btnTimePicker: some View {
        Button {
            showTimePicker.toggle()
        } label: {
            Text(LocalizedString.selectTime)
                .themeButton()
        }
        
    }
    
    var btnSelectSingleDate: some View {
        Button {
            pickerViewModel.configureForSingleDateSelection()
            showCalender.toggle()
        } label: {
            Text(LocalizedString.selectSingleDate)
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
            Text(LocalizedString.selectMultipleDate)
                .themeButton()
            
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PickerExampleView()
    }
}
