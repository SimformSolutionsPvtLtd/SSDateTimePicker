//
//  ThemeButton.swift
//  Example
//
//  Created by Rizwana Desai on 12/12/23.
//

import SwiftUI

struct ThemeButton: ViewModifier {
    
    func body(content: Content) -> some View {
       content
            .frame(maxWidth: .infinity, minHeight: 44)
            .font(.system(size: 14, weight: .semibold))
            .background(Color.darkPink)
            .foregroundColor(Color.white)
            .cornerRadius(10)
            .padding(.leading, 20)
            .padding(.trailing, 20)
     }
    
}
