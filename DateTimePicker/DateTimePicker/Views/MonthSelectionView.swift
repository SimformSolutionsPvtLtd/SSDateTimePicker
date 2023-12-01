//
//  MonthSelectionView.swift
//  DateTimePicker
//
//  Created by Rizwana Desai on 24/11/23.
//

import SwiftUI

struct MonthSelectionView: View {
    
    //MARK: - Property
  
    private var gridItem: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
    
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
                ForEach(DateFormatter.monthsList, id: \.self) { month in
                    btnMonth(for: month)
                }
            }
        }
    }
    
    func btnMonth(for month: String) -> some View {
        Button {
            
        } label: {
            Text(month)
                .font(.footnote)
                .foregroundColor(SSCalendarTheme.dateMonthYearColor)
        }
    }
    
}

struct MonthSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        MonthSelectionView()
    }
}
