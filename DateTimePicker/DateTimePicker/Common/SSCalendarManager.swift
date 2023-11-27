//
//  SSCalendarManager.swift
//  DateTimePicker
//
//  Created by Rizwana Desai on 27/11/23.
//

import Foundation

public class SSCalendarManager: ObservableObject {
    
    @Published public private(set) var currentMonth: Date
    @Published public var selectedDate: Date? = nil

    public init(currentMonth: Date, selectedDate: Date? = nil) {
        self.currentMonth = currentMonth
        self.selectedDate = selectedDate
    }
    
    
    func actionNext(for year: Bool) {
        if year {
            //TODO: Next year
            currentMonth = currentMonth.getNextMonth() ?? currentMonth
        } else {
            currentMonth = currentMonth.getNextMonth() ?? currentMonth
        }
    }
    
    func actionPrev(for year: Bool) {
        if year {
            //TODO: Previous year
            currentMonth = currentMonth.getPreviousMonth() ?? currentMonth
        } else {
            currentMonth = currentMonth.getPreviousMonth() ?? currentMonth
        }
    }
}
