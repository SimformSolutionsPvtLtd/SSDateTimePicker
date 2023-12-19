//
//  Calendar+Extension.swift
//  DateTimePicker
//
//  Created by Rizwana Desai on 24/11/23.
//

import Foundation

extension Calendar {
    
    // MARK: - Generate Dates Inside Interval
    
    /// Generates an array of dates within the specified date interval that match the given components.
    ///
    /// - Parameters:
    ///   - interval: The date interval within which to generate dates.
    ///   - components: The date components to match for each generated date.
    ///
    /// Example:
    /// ```swift
    /// let startDate = Date()
    /// let endDate = Calendar.current.date(byAdding: .month, value: 1, to: startDate)!
    /// let dateComponents = DateComponents(hour: 12, minute: 0)
    /// let generatedDates = Calendar.current.generateDates(inside: DateInterval(start: startDate, end: endDate), matching: dateComponents)
    /// ```
    ///
    /// - Returns: An array of dates within the specified interval that match the provided components.
    func generateDates(inside interval: DateInterval,
                       matching components: DateComponents) -> [Date] {
        var dates: [Date] = []
        dates.append(interval.start)
        
        enumerateDates(
            startingAfter: interval.start,
            matching: components,
            matchingPolicy: .nextTime) { date, _, stop in
                if let date = date {
                    if date < interval.end {
                        dates.append(date)
                    } else {
                        stop = true
                    }
                }
            }
        return dates
    }
    
    // MARK: - First Day of Every Week Date Components
    
    /// Represents a `DateComponents` instance set to midnight on the first day of the week.
    ///
    /// Example:
    /// ```swift
    /// let firstDayOfTheWeek = Calendar.current.firstDayOfEveryWeek
    /// // Use `firstDayOfTheWeek` to determine the starting date for a weekly calendar view.
    /// ```
    ///
    /// - Note: The actual first day of the week is determined by the `firstWeekday` property of the calendar.
    ///
    /// - Returns: A `DateComponents` instance with hour, minute, and second set to zero and the weekday set to the first day of the week.
    var firstDayOfEveryWeek: DateComponents {
        DateComponents(hour: 0, minute: 0, second: 0, weekday: firstWeekday)
    }
    
    // MARK: - Compare Dates to Granularities
    
    /// Compares two dates based on specified granularities and determines if they are equal.
    ///
    /// - Parameters:
    ///   - date1: The first date to compare.
    ///   - date2: The second date to compare.
    ///   - components: The set of granularities to consider in the comparison.
    ///
    /// Example:
    /// ```swift
    /// let startDate = Date()
    /// let endDate = Calendar.current.date(byAdding: .day, value: 1, to: startDate)!
    /// let granularities: Set<Calendar.Component> = [.year, .month, .day]
    /// let result = Calendar.current.isDate(startDate, equalTo: endDate, toGranularities: granularities)
    /// print(result) // true if the dates are equal up to the specified granularities.
    /// ```
    ///
    /// - Returns: `true` if the dates are equal up to the specified granularities; otherwise, `false`.
    func isDate(_ date1: Date, equalTo date2: Date, toGranularities components: Set<Calendar.Component>) -> Bool {
        components.reduce(into: true) { isEqual, component in
            isEqual = isEqual && isDate(date1, equalTo: date2, toGranularity: component)
        }
    }
    
}
