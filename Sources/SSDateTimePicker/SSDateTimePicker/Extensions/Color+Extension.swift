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
    
    public static let lightGreen: Color = Color("lightGreen")
    public static let darkGreen: Color = Color("darkGreen")
    public static let darkPink: Color = Color("darkPink")
    public static let lightPink: Color = Color("lightPink")
    public static let lightBlue: Color = Color("lightBlue")
    public static let peach: Color = Color("peach")
    
}

