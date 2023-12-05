//
//  YearSelectionView.swift
//  DateTimePicker
//
//  Created by Rizwana Desai on 24/11/23.
//

import SwiftUI

public struct YearSelectionView: View, ConfigurationDirectAccess {
    
    //MARK: - Property
    
    @Binding var currentView: SelectionView
    @EnvironmentObject var calendarManager: SSDatePickerManager
    private var gridItem: [GridItem] = Array(repeating: .init(.flexible()), count: SSPickerConstants.monthYearGridRows)
    
    var configuration: SSDatePickerConfiguration {
        calendarManager.configuration
    }
    
    //MARK: - init

    public init(currentView: Binding<SelectionView>) {
        self._currentView = currentView
    }

    //MARK: - Body
    
    public var body: some View {
        yearsGridView
            .padding(.top, SSPickerConstants.monthYearViewTopSpace)
            .padding(.bottom, SSPickerConstants.monthYearViewBottomSpace)
            .onAppear {
                calendarManager.updateYearRange(year: (calendarManager.selectedDate ?? calendarManager.currentMonth).year(calendar))
            }
    }
    
    //MARK: - Sub views
    
    var yearsGridView: some View {
        HStack {
            LazyVGrid(columns: gridItem, spacing: SSPickerConstants.monthYearGridSpacing) {
                ForEach(calendarManager.yearRange, id: \.self) { year in
                    btnYear(for: year)
                }
            }
        }
    }
    
    @ViewBuilder
    func btnYear(for year: Int) -> some View {
        let isSelectedYear = calendarManager.isSelected(year)
        Button {
            updateYearSelection(year: year)
        } label: {
            Text(String(year))
                .font(.system(size: 14, weight: isSelectedYear ? .bold : .regular))
                .foregroundColor(isSelectedYear ? selectionBackgroundColor : dateMonthYearTextColor)
        }
    }
    
    //MARK: - Methods

    func updateYearSelection(year: Int) {
        calendarManager.updateYearSelection(year: year)
        currentView = .month
    }

}
