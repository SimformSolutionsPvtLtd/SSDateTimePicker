//
//  PickerViewModel.swift
//  Example
//
//  Created by Rizwana Desai on 01/12/23.
//

import Foundation
import SSDateTimePicker
import SwiftUI

final class PickerViewModel: ObservableObject {
    
    // MARK: - Properties

    @Published var selectedDate: Date?
    @Published var selectedDates: [Date]?
    @Published var selectedDateRange: DateRange?
    @Published var selectedTime: Date?
    
    //MARK: - Initializer
    
    init() {
        
    }
    
    //MARK: - Methods
    
    func getSelectedDates() -> String? {
        let dates = self.selectedDates?.compactMap({ date in
            date.monthDateYear
        }).joined(separator: ",")
        return dates
    }
    
}
