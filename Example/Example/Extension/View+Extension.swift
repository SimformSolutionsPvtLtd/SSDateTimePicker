//
//  View+Extension.swift
//  Example
//
//  Created by Rizwana Desai on 15/12/23.
//

import SwiftUI

extension View {
    
    func themeButton() -> some View {
        self.modifier(ThemeButton())
    }
    
    func themeCard() -> some View {
        self.modifier(ThemeCard())
    }
    
}
