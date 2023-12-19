//
//  PickerExampleView.swift
//  Example
//
//  Created by Rizwana Desai on 22/11/23.
//

import SwiftUI
import SSDateTimePicker

struct PickerExampleView: View {
    
    //MARK: - Properties
    
    @State var showDatePicker: Bool = false
    @State var showMultiDatePicker: Bool = false
    @State var showDateRangePicker: Bool = false
    @State var showTimePicker: Bool = false
    @State var displayCustomizedCalendar: Bool = false
    @State var selectedDate: Date = Date()
    @State var selectedDateCombine: Date?
    @ObservedObject var pickerViewModel = PickerViewModel()
    
    //MARK: - Body
    var body: some View {
        dateTimePickerExampleView
            .fullScreenCover(isPresented: $showDatePicker) {
                datePicker
            }
            .fullScreenCover(isPresented: $showDateRangePicker, content: {
                dateRangePicker
            })
            .fullScreenCover(isPresented: $showMultiDatePicker, content: {
                multiDatePicker
            })
            .fullScreenCover(isPresented: $showTimePicker) {
                // Time Picker
                timePicker
                    .background(ClearBackgroundView())
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
            Text("\(LocalizedString.startDate) \(pickerViewModel.selectedDateRange?.startDate.monthDateYear ?? "-"),  \(LocalizedString.endDate) \(pickerViewModel.selectedDateRange?.endDate.monthDateYear ?? "-")")
                .font(.footnote)
            btnSelectDateRange
        }
        .themeCard()
    }
    
    var btnSelectDateRange: some View {
        Button {
            showDateRangePicker.toggle()
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
            showDatePicker.toggle()
        } label: {
            Text(LocalizedString.selectSingleDate)
                .themeButton()
        }
    }
    
    var btnSelectMultipleDates: some View {
        Button {
            showMultiDatePicker.toggle()
        } label: {
            Text(LocalizedString.selectMultipleDate)
                .themeButton()
        }
    }
    
    var datePicker: some View {
        SSDatePicker(showDatePicker: $showDatePicker)
            .selectedDate(self.pickerViewModel.selectedDate)
            .onDateSelection({ date in
                self.pickerViewModel.selectedDate = date
            })
            .background(ClearBackgroundView())
    }
    
    var dateRangePicker: some View {
        SSDatePicker(showDatePicker: $showDateRangePicker)
            .enableDateRangeSelection()
            .selectedDates(pickerViewModel.selectedDateRange)
            .onDateRangeSelection({ dateRange in
                pickerViewModel.selectedDateRange = dateRange
            })
            .background(ClearBackgroundView())
    }
    
    var multiDatePicker: some View {
        SSDatePicker(showDatePicker: $showMultiDatePicker)
            .disableDates([Date()])
            .themeColor(pickerBackgroundColor: .lightGreen, primaryColor: .darkGreen)
            .enableMultipleDateSelection()
            .selectedDates(pickerViewModel.selectedDates)
            .onMultiDateSelection({ dates in
                pickerViewModel.selectedDates = dates
            })
            .background(ClearBackgroundView())
    }
    
    var timePicker: some View {
        SSTimePicker(showTimePicker: $showTimePicker)
            .selectedTime(pickerViewModel.selectedTime)
            .buttonStyle(color: .darkGreen)
            .onTimeSelection { time in
                pickerViewModel.selectedTime = time
            }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PickerExampleView()
    }
}
