//
//  YearSelectionView.swift
//  DateTimePicker
//
//  Created by Rizwana Desai on 24/11/23.
//

import SwiftUI

public struct SSYearSelectionView: View, DatePickerConfigurationDirectAccess {
    
    // MARK: - Properties

    @Binding var currentView: SelectionView
    @EnvironmentObject var calendarManager: SSDatePickerManager
    private var gridItem: [GridItem] = Array(repeating: .init(.flexible()), count: SSPickerConstants.monthYearGridRows)
    
    var configuration: SSDatePickerConfiguration {
        calendarManager.configuration
    }
    
    //MARK: - Initializer

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
    
    private var yearsGridView: some View {
        HStack {
            LazyVGrid(columns: gridItem, spacing: SSPickerConstants.monthYearGridSpacing) {
                ForEach(calendarManager.yearRange, id: \.self) { year in
                    btnYear(for: year)
                }
            }
        }
    }
    
    @ViewBuilder
    private func btnYear(for year: Int) -> some View {
        let isSelectedYear = calendarManager.isSelected(year)
        Button {
            updateYearSelection(year: year)
        } label: {
            Text(String(year))
                .font(isSelectedYear ? selectedYearTextFont : yearTextFont)
                .foregroundColor(isSelectedYear ? selectionBackgroundColor : dateMonthYearTextColor)
        }
    }
    
    //MARK: - Methods

    private func updateYearSelection(year: Int) {
        calendarManager.updateYearSelection(year: year)
        currentView = .month
    }

}
