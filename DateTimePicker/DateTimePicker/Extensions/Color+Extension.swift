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
        self.init(UIColor(named: name, in: Bundle.dateTimePickerBundle, compatibleWith: nil)!)
    }
    
    static let lightGreen: Color = Color("lightGreen")
    static let darkGreen: Color = Color("darkGreen")
    static let darkPink: Color = Color("darkPink")
    static let lightPink: Color = Color("lightPink")
    static let lightBlue: Color = Color("lightBlue")
    static let peach: Color = Color("peach")
}

