//
//  YearSelectionView.swift
//  DateTimePicker
//
//  Created by Rizwana Desai on 24/11/23.
//

import SwiftUI

struct YearSelectionView: View {
    
    //MARK: - Property
    private var gridItem: [GridItem] = Array(repeating: .init(.flexible()), count: 3)

    @Binding var selectedYear: Int
    
    private var yearRange: ClosedRange<Int> {
        let lowerBound = selectedYear - 10
        let upperBound = selectedYear
        return lowerBound...upperBound
    }
    
    public init(selectedYear: Binding<Int>) {
        self._selectedYear = selectedYear
    }

    
    //MARK: - Body
    var body: some View {
        yearsGridView
            .padding(.top, 20)
            .padding(.bottom, 20)
    }
    
    //MARK: - Sub views
    var yearsGridView: some View {
        HStack {
            LazyVGrid(columns: gridItem, spacing: SSCalendarConstants.monthYearGridSpacing) {
                ForEach(yearRange, id: \.self) { year in
                    btnYear(for: year)
                }
            }
        }
    }
    
    func btnYear(for year: Int) -> some View {
        Button {
            selectedYear = year
        } label: {
            Text(String(year))
                .font(.footnote)
                .foregroundColor(SSCalendarTheme.dateMonthYearColor)
        }
    }
    
}

struct YearSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        YearSelectionView(selectedYear: .constant(2023))
    }
}
