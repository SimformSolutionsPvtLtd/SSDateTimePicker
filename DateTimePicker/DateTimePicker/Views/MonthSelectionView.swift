//
//  MonthSelectionView.swift
//  DateTimePicker
//
//  Created by Rizwana Desai on 24/11/23.
//

import SwiftUI

struct MonthSelectionView: View, ConfigurationDirectAccess {
    
    //MARK: - Property
    @State var monthList: [String] = DateFormatter.monthsList
   
    @EnvironmentObject var calendarManager: SSCalendarManager

    private var gridItem: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
    
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
                ForEach(monthList, id: \.self) {  month in
                    btnMonth(for: month)
                }
            }
        }
    }
    
    @ViewBuilder
    func btnMonth(for month: String) -> some View {
        let monthName = month
        let isSelectedMonth = calendarManager.isSelected(monthName)
        Button {
            updateMonth(month: month)
        } label: {
            Text(monthName)
                .font(.system(size: 14, weight: isSelectedMonth ? .bold : .regular))
                .foregroundColor(isSelectedMonth ? selectionBackgroundColor : dateMonthYearTextColor)
        }
    }
    
    func updateMonth(month: String) {
        guard let month = monthList.firstIndex(where: { $0 == month}) else { return }
        calendarManager.updateMonthSelection(month: month+1)
    }
        
}

struct MonthSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        MonthSelectionView()
    }
}
