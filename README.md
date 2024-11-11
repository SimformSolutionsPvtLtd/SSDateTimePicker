

<img width="1280" alt="SSDateTimePicker" src="https://github.com/SimformSolutionsPvtLtd/SSDateTimePicker/assets/151725480/8628147d-ec3d-4423-847a-c5eb0177ff45">


# SSDateTimePicker

SSDateTimePicker is a SwiftUI library that simplifies date and time selection in your applications, providing a variety of features and a customizable UI for both date and time pickers.

<table>
    <thead>
        <tr>
            <th>Time Picker</th>
            <th>Date Picker</th>
            <th>Multiple Date Picker</th>
            <th>Date Range Picker</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>
                <img  width=200px src="https://github.com/SimformSolutionsPvtLtd/SSDateTimePicker/assets/151725480/5838d32f-5126-4009-9d01-88fbd2afa482" />
            </td>
            <td>
                <img width=200px src="https://github.com/SimformSolutionsPvtLtd/SSDateTimePicker/assets/151725480/0cbae52b-4876-4e3b-b2a5-bfdd32e73618" />
            </td>
            <td>
                <img  width=200px src="https://github.com/SimformSolutionsPvtLtd/SSDateTimePicker/assets/151725480/b4b0d3a4-aade-4eaf-aec4-aed15b787ea7" />
            </td>
            <td>
                <img  width=200px src="https://github.com/SimformSolutionsPvtLtd/SSDateTimePicker/assets/151725480/2c4ed25c-dd70-4b0e-b6ac-6ad375b24188" />
            </td>
        </tr>
    </tbody>
</table>


## Features!
* Single Date Selection
* Multiple Date Selection
* Date Range Selection
* Disable Past or Future Dates
* Disable Specific Dates
* Limit date selection to a predefined range
* Time selection with a clock-style interface
* Personalize fonts and colors for seamless integration with your app's design.

## Requirements

* iOS 15.0+
* Xcode 12+

## Installation

### [Swift Package Manager](https://swift.org/package-manager/)

You can install `SSDateTimePicker` using Swift Package Manager by:

1. Go to `Xcode` -> `File` -> `Add Package Dependencies...`
2. Add package URL [https://github.com/SimformSolutionsPvtLtd/SSDateTimePicker][SSDateTimePicker]

### [CocoaPods](http://cocoapods.org)

To install `SSDateTimePicker`, simply add the following line to your Podfile:

```swift
pod 'SSDateTimePicker'
```


## Usage

### SSDatePicker

SSDatePicker offers versatile date selection options, including single date, multiple date, and date range selection. Follow this guide to set up the date picker according to your preferences:

1. import `SSDateTimePicker`.
2. Add a bool to control date picker presentation state.
3. Add a `SSDatePicker` in your view.


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

1. Add `.selectedDate(selectedDate)` modifier to pre-select specific date.
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
2. Set `.onTimeSelection` callback to get selected date range.

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

Explore the following modifiers to effortlessly customize the UI and behaviour of SSDateTimePicker to suit your preferences.

### SSDatePicker

###### Behavioral Modifiers

- `.minimumDate(_ date: Date)` - Set the minimum selectable date in the date picker.
- `.maximumDate(_ date: Date)` - Set the maximum selectable date in the date picker.
- `.disableDates(_ dates: [Date])` - Block the selection of specific dates.
- `.disablePastDate()` - Prevent the selection of past dates.
- `.disableFutureDate()` - Prevent the selection of future dates.
- `.currentMonth(_ date: Date)` - Set the initial display month in the date picker, providing a specific starting point when the picker is opened. By default it will open current month claendar.
- `.enableDateRangeSelection()` -  Enable the selection of date range.
- `.enableMultipleDateSelection()` - Enable the selection of multiple dates.
- `.selectedDate(_ date: Date?)` - Pre-select a specific date in the date picker.
- `.selectedDates(_ dates: [Date]?)` - Pre-select a specific dates in the date picker.
- `.selectedDates(_ dateRange: DateRange?)` - Pre-select a specific date range in the date picker.
- `.calendar(_ calendar: Calendar)` - Set the calendar used by the date picker.

###### UI Modifiers

- `.themeColor(pickerBackgroundColor: Color, primaryColor: Color)` - Define the overall theme color, where the primary color sets the background of selected dates, buttons and selectected month, year foreground.
- `.todayColor(backgroundColor: Color?, foregroundColor: Color?)` - Highlight today's date with specific foreground and background colors.
- `.todayDateSelectionColor(backgroundColor: Color?, foregroundColor: Color?)` - Adjust the foreground and background colors for the today's date selection state.
- `.headerTitleStyle(color: Color?, font: Font?)` - Customize the font and color of the header text.
- `.headerDateStyle(color: Color?, font: Font?)` - Customize font and color for header date text.
- `.weekdayStyle(color: Color?, font: Font?)`  - Adjust the text color and font of weekdays.
- `.dateStyle(color: Color?, font: Font?)` - Customize color and font for date text.
- `.monthStyle(color: Color?, font: Font?)` - Modify the font and color for the selected month.
- `.selectedMonthStyle(color: Color?, font: Font?)` - Customize font and color for selected month.
- `.yearStyle(color: Color?, font: Font?) -> SSDatePicker ` - Customize the text color and font for the year text.
- `.selectedYearStyle(color: Color?, font: Font?)` - Adjust the font and color for the selected year.
- `.buttonStyle(color: Color?, font: Font?)` -  Set the font and color for the buttons.
- `.currentMonthYearLabelStyle(color: Color?, font: Font?)` -  Customize the color and font for the label displaying the current month and year in the bottom navigation.
- `.selectedDateColor(backgroundColor: Color?, foregroundColor: Color?) ` - Change the foreground and background color for selected dates.
- `.pickerBackgroundColor(_ color: Color) ` - Define the background color of the entire picker view.
- `.sepratorLineColor(_ color: Color)` - Change the color of the separator line within the picker.
- `.popupOverlayColor(_ color: Color)` - Customize the color of the popup overlay,

### SSTimePicker

- `themeColor(pickerBackgroundColor: Color, primaryColor: Color, timeLabelBackgroundColor: Color)` - Apply a custom color scheme to the time picker, primary color is designated for the clock hand and the foreground of the time label.
- `selectedTime(_ time: Time?)` - Set the initially selected time for the time picker.
- `headerTitleStyle(color: Color?, font: Font?)` - Customize the style of the header title.
- `timeLabelStyle(color: Color?, font: Font?)` - Customize time label(HH:MM) font and foreground color.
- `timeFormatStyle(color: Color?, font: Font?)` - Modify Time format(AM/PM) color and font.
- `selectedTimeFormatStyle(color: Color?, font: Font?)` - Customize selected time format(AM/PM) style.
- `clockNumberStyle(color: Color?, font: Font?)` - Customize the style of the clock numbers.
- `buttonStyle(color: Color?, font: Font?)` - Customize buttons font and foreground color.

## Find this samples useful? :heart:

Support it by joining [stargazers] :star: for this repository.

## How to Contribute :handshake:

Whether you're helping us fix bugs, improve the docs, or a feature request, we'd love to have you! :muscle: \
Check out our __[Contributing Guide]__ for ideas on contributing.

## Bugs and Feedback

For bugs, feature feature requests, and discussion use [GitHub Issues].

## Other Mobile Libraries

Check out our other libraries [Awesome-Mobile-Libraries].

## License

Distributed under the MIT license. See [LICENSE] for details.


<!-- Reference links -->

[SSDateTimePicker]:            https://github.com/SimformSolutionsPvtLtd/SSDateTimePicker

[Swift Package Manager]:    https://www.swift.org/package-manager

[stargazers]:               https://github.com/SimformSolutionsPvtLtd/SSDateTimePicker/stargazers

[Awesome-Mobile-Libraries]: https://github.com/SimformSolutionsPvtLtd/Awesome-Mobile-Libraries

[license]:                  LICENSE

[Github Issues]:            https://github.com/SimformSolutionsPvtLtd/SSDateTimePicker/issues

[Contributing Guide]:       CONTRIBUTING.md



