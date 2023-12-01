//
//  Color+Extension.swift
//  DateTimePicker
//
//  Created by Rizwana Desai on 24/11/23.
//

import Foundation
import SwiftUI

extension Color {
  
    init(_ name: String) {
        self.init(UIColor(named: name, in: Bundle.calendarBundle, compatibleWith: nil)!)
    }
    
    static let fluorescentPink: Color = Color("fluorescentPink")
    static let mauvePurple: Color = Color("mauvePurple")
    static let lightGreen: Color = Color("lightGreen")
    static let darkGreen: Color = Color("darkGreen")
    static let themeBlack: Color = Color("themeBlack")

}

