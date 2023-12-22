//
//  Color+Extension.swift
//  DateTimePicker
//
//  Created by Rizwana Desai on 24/11/23.
//

import Foundation
import SwiftUI

public extension Color {
   
    static let lightGreen: Color = Color(red: 230, green: 234, blue: 221)
    static let darkGreen: Color = Color(red: 68, green: 105, blue: 43)
    static let darkPink: Color = Color(red: 221, green: 94, blue: 105)
    static let lightPink: Color = Color(red: 253, green: 250, blue: 250)
    static let lightBlue: Color = Color(red: 242, green: 244, blue: 252)
    static let peach: Color = Color(red: 244, green: 209, blue: 213)
    
}

fileprivate extension Color {

    init(red: Int, green: Int, blue: Int) {
        self.init(red: Double(red)/255, green: Double(green)/255, blue: Double(blue)/255)
    }

}
