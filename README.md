# SSDateTimePicker

SSDateTimePicker simplifies date and time selection in your applications, offering a range of features and a customizable UI for both date and time pickers.

## Features!
* Single Date Selection
* Multiple Date Selection
* Date Range Selection
* Disable Past or Future Dates
* Disable Specific Dates
* Limit date selection to a predefined range
* Time selection with a clock-style interface
* Personalize fonts and colors for seamless integration with your app's design.

## Usage

### SSDatePicker

SSDatePicker offers versatile date selection options, including single date, multiple date, and date range selection. Follow this guide to set up the date picker according to your preferences:

1. import `SSDateTimePicker`
2. Add a bool to control date-time picker presentation state
3. Add a `SSDatePicker` in your view


```swift
import SSDateTimePicker

struct PickerExample: View {

    @State var showDatePicker: Bool = false
    @State var selectedDate: Date?

    var body: some View {
        ZStack {
            Text("Your view")
            SSDatePicker(showDatePicker: $showDatePicker)
        }
    }
}
```

###### Single Date Selection Picker

1. Add `.selectedDate(selectedDate)` modifier to pre-select specific date
2. Set the callback closure ` .onDateSelection` to get selected date.

```swift
 SSDatePicker(showDatePicker: $showDatePicker)
                .selectedDate(selectedDate)
                .onDateSelection({ date in
                    selectedDate = date
                })
```

###### Multiple date selection picker
1. To enable multiple date selection add `.enableMultipleDateSelection()` modifier.
2. Add `.selectedDates(selectedDates)` modifier to pre-select specific dates.
4. Set `.onMultiDateSelection` callback to get selected multiple dates.

```swift
        SSDatePicker(showDatePicker: $showDatePicker)
            .enableMultipleDateSelection()
            .selectedDates(selectedDates)
            .onMultiDateSelection({ dates in
                selectedDates = dates
            })
```

###### Date Range Selection Picker

1. To enable date range selection add `.enableDateRangeSelection()` modifier.
2. Add `.selectedDateRange(selectedDateRange))` modifier to pre-select specific dates.
2. Sets `.onDateRangeSelection` callback to get selected date range.

```swift
        SSDatePicker(showDatePicker: $showDatePicker)
            .enableDateRangeSelection()
            .selectedDateRange(selectedDateRange)
            .onDateRangeSelection({ dateRange in
                selectedDateRange = dateRange
            })
```

### SSTimePicker

1. import `SSDateTimePicker`
2. Add a bool to control date-time picker presentation state
3. Add a `SSTimePicker` in your view
4. Add `.selectedTime(pickerViewModel.selectedTime)` modifier to pre-select specific dates.
2. Sets `.onDateRangeSelection` callback to get selected date range.

```swift
import SSDateTimePicker

struct TimePickerExample: View {

    @State var showTimePicker: Bool = false
    @State var selectedTime: Time?

    var body: some View {
        ZStack {
            Text("Your view")
            SSTimePicker(showTimePicker: $showTimePicker)
                .selectedTime(selectedTime)
                .onTimeSelection { time in
                    selectedTime = time
                }
        }
    }
}
```

## Configuration Guide

Explore the following modifiers to effortlessly customize the UI of SSDatePicker to suit your preferences.

###### SSDatePicker Modifiers

- `.themeColor(pickerBackgroundColor: Color, primaryColor: Color)` - Set up the theme color, where the primary color is used for both the selected date's background and buttons.
- `enableDateRangeSelection()` -  To allow date range selection
- `enableMultipleDateSelection()` - To allow multiple date selection
- `selectedDates(_ dates: [Date]?)` - Sets the selected dates for the multi-date picker.
- `selectedDates(_ dateRange: DateRange?)` - set selected date range for range selection picker
- `.minimumDate(_ date: Date)` - Sets the minimum selectable date in the date picker.
- `.maximumDate(_ date: Date)` - Sets the maximum selectable date in the date picker.
- `.disablePastDate()` - Disables selection of past dates in the date picker.
- `.disableFutureDate()` - Disables selection of future dates in the date picker.
- `.currentMonth(_ date: Date)` - The current month displayed in the date picker.
- `selectedDate(_ date: Date?)` - The selected date in the date picker. Set this property to pre-select a specific date.
- `disableDates(_ dates: [Date])` - disable specific dates in date picker
- `.calendar(_ calendar: Calendar)` - Sets the calendar used by the date picker, default is current.
- `.headerTitleStyle(color: Color?, font: Font?)` - set up header text font and color
- `.headerDateStyle(color: Color?, font: Font?)` - set up header date text font and color
- `.weekdayStyle(color: Color?, font: Font?)`  - set up weekday text color and font

- `.dateStyle(color: Color?, font: Font?)` - set up date text color and font
- `.monthStyle(color: Color?, font: Font?)` - set up month text color and font
- `.selectedMonthStyle(color: Color?, font: Font?)` - change font and color for selected month.
- `.yearStyle(color: Color?, font: Font?) -> SSDatePicker ` - set up year text color and font
- `.selectedYearStyle(color: Color?, font: Font?)` -  change font and color for selected year.
- `.buttonStyle(color: Color?, font: Font?)` - set up font and color for buttons
- `.currentMonthYearLabelStyle(color: Color?, font: Font?)` - to set Current month year bottom navigation color and font
- `.selectedDateColor(backgroundColor: Color?, foregroundColor: Color?) ` - chnage selected date foreground color and background color
- `.todayColor(backgroundColor: Color?, foregroundColor: Color?)` - heighlight todays date using this modifiers, set foreground and background color
- `.todayDateSelectionColor(backgroundColor: Color?, foregroundColor: Color?)` - Today's date selection state foreground and background color
- `.pickerBackgroundColor(_ color: Color) ` - PickerView background color
- `.sepratorLineColor(_ color: Color)` - to change seprator line color
- `.popupOverlayColor(_ color: Color)` - to change popupoverlay color





