//
//  ThemeButton.swift
//  DateTimePicker
//
//  Created by Rizwana Desai on 01/12/23.
//

import SwiftUI

struct ThemeButtonModifier: ViewModifier {
  
    var textColor: Color
    
    func body(content: Content) -> some View {
       content
            .font(.system(size: 15, weight: .semibold))
            .padding(SSPickerConstants.paddingTen)
            .foregroundColor(textColor)
     }
    
}
