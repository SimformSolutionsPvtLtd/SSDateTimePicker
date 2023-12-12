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
            .foregroundColor(Color.darkPink)
     }
    
}

extension View {
    func themeButton() -> some View {
        self.modifier(ThemeButton())
    }
}
