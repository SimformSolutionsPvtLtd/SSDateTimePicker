//
//  ThemeButton.swift
//  DateTimePicker
//
//  Created by Rizwana Desai on 01/12/23.
//

import SwiftUI

struct ThemeButtonModifier: ViewModifier {
  
    var textColor: Color
    var font: Font
    
    func body(content: Content) -> some View {
       content
            .font(font)
            .padding(SSPickerConstants.paddingTen)
            .foregroundColor(textColor)
     }
    
}
