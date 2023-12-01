//
//  YearSelectionView.swift
//  DateTimePicker
//
//  Created by Rizwana Desai on 24/11/23.
//

import SwiftUI

struct YearSelectionView: View, ConfigurationDirectAccess {
    
    //MARK: - Property
    @EnvironmentObject var calendarManager: SSCalendarManager

    private var gridItem: [GridItem] = Array(repeating: .init(.flexible()), count: 3)    
    
    var configuration: SSCalendarConfiguration {
        calendarManager.configuration
    }

    //MARK: - Body
    var body: some View {
        yearsGridView
            .padding(.top, 20)
            .padding(.bottom, 20)
            .onAppear {
                calendarManager.updateYearRange(year: (calendarManager.selectedDate ?? calendarManager.currentMonth).year)
            }
    }
    
    //MARK: - Sub views
    var yearsGridView: some View {
        HStack {
            LazyVGrid(columns: gridItem, spacing: SSCalendarConstants.monthYearGridSpacing) {
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
    
    func updateYearSelection(year: Int) {
        calendarManager.updateYearSelection(year: year)
    }

}

struct YearSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        YearSelectionView()
    }
}