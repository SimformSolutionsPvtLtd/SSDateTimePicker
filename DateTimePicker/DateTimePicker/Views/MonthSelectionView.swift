//
//  MonthSelectionView.swift
//  DateTimePicker
//
//  Created by Rizwana Desai on 24/11/23.
//

import SwiftUI

struct MonthSelectionView: View, ConfigurationDirectAccess {
    
    //MARK: - Property
  
    private var gridItem: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
    @EnvironmentObject var calendarManager: SSCalendarManager
    var configuration: SSCalendarConfiguration {
        calendarManager.configuration
    }
    
    //MARK: - Body

    var body: some View {
        monthsGridView
            .padding(.top, 20)
            .padding(.bottom, 20)
    }
    
    //MARK: - Sub views

    var monthsGridView: some View {
        HStack {
            LazyVGrid(columns: gridItem, spacing: SSCalendarConstants.monthYearGridSpacing) {
                ForEach(0..<DateFormatter.monthsList.count, id: \.self) { index in
                    btnMonth(for: index)
                }
            }
        }
    }
    
    @ViewBuilder
    func btnMonth(for month: Int) -> some View {
        let monthName = DateFormatter.monthsList[month]
        let isSelectedMonth = calendarManager.isSelected(monthName)
        Button {
            updateMonth(month: month)
        } label: {
            Text(monthName)
                .font(.system(size: 14, weight: isSelectedMonth ? .bold : .regular))
                .foregroundColor(isSelectedMonth ? selectionBackgroundColor : dateMonthYearTextColor)
        }
    }
    
    func updateMonth(month: Int) {
        calendarManager.updateMonthSelection(month: month+1)
    }
        
}

struct MonthSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        MonthSelectionView()
    }
}
