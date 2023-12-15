//
//  ThemeCard.swift
//  Example
//
//  Created by Rizwana Desai on 15/12/23.
//

import SwiftUI

struct ThemeCard: ViewModifier {
  
    func body(content: Content) -> some View {
        content
            .padding(20)
            .background(Color.lightPink)
            .clipShape(RoundedRectangle(cornerRadius: 0.0))
            .shadow(color: .peach, radius: 2)
            .padding(EdgeInsets(top: 10, leading: 20, bottom: 0, trailing: 20))
    }
    
}

