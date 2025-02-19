//
//  MonthSelectionView.swift
//  DateTimePicker
//
//  Created by Rizwana Desai on 24/11/23.
//

import SwiftUI

struct SSMonthSelectionView: View, DatePickerConfigurationDirectAccess {
    
    // MARK: - Properties

    @EnvironmentObject var calendarManager: SSDatePickerManager
    @State var monthList: [String] = DateFormatter.monthsList
    private var gridItem: [GridItem] = Array(repeating: .init(.flexible()), count: SSPickerConstants.monthYearGridRows)
    
    var configuration: SSDatePickerConfiguration {
        calendarManager.configuration
    }
    
    //MARK: - Body

    var body: some View {
        monthsGridView
            .padding(.top, SSPickerConstants.monthYearViewTopSpace)
            .padding(.bottom, SSPickerConstants.monthYearViewBottomSpace)
    }
    
    //MARK: - Sub views

    private var monthsGridView: some View {
        HStack {
            LazyVGrid(columns: gridItem, spacing: SSPickerConstants.monthYearGridSpacing) {
                ForEach(monthList, id: \.self) {  month in
                    btnMonth(for: month)
                }
            }
        }
    }
    
    @ViewBuilder
    private func btnMonth(for month: String) -> some View {
        let monthName = month
        let isSelectedMonth = calendarManager.isSelected(monthName)
        Button {
            updateMonth(month: month)
        } label: {
            Text(monthName)
                .font(isSelectedMonth ? selectedMonthTextFont : monthTextFont)
                .foregroundColor(isSelectedMonth ? selectionBackgroundColor : dateMonthYearTextColor)
        }
    }
    
    //MARK: - Methods

    private func updateMonth(month: String) {
        guard let month = monthList.firstIndex(where: { $0 == month}) else { return }
        calendarManager.updateMonthSelection(month: month+1)
    }
        
}
