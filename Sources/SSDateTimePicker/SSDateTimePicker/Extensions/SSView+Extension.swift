//
//  View+Extension.swift
//  DateTimePicker
//
//  Created by Rizwana Desai on 30/11/23.
//

import Foundation
import SwiftUI

extension View {
    
    /// Applies the given transform if the given condition evaluates to `true`.
    /// - Parameters:
    ///   - condition: The condition to evaluate.
    ///   - transform: The transform to apply to the source `View`.
    /// - Returns: Either the original `View` or the modified `View` if the condition is `true`.
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
    
    // MARK: - Corner Radius Modifier
    
    /// Applies a corner radius to specific corners of a view using a custom modifier.
    ///
    /// - Parameters:
    ///   - radius: The radius of the corner.
    ///   - corners: The corners to which the radius should be applied.
    ///
    /// Example:
    /// ```
    /// someView.cornerRadius(10, corners: [.topLeft, .bottomRight])
    /// ```
    ///
    /// - Returns: A modified version of the view with the specified corner radius applied.
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        ModifiedContent(content: self, modifier: SSCornerRadiusStyle(radius: radius, corners: corners))
    }
    
    /// Applies a theme-specific button style to the view using a custom modifier.
    ///
    /// - Parameters:
    ///   - txtColor: The color of the text within the button.
    ///   - font: The font style for the text within the button.
    ///
    /// Example:
    /// ```
    /// someView.themeButton(.blue, .headline)
    /// ```
    ///
    /// - Returns: A modified version of the view with the specified text color and font for a themed button.
    func themeButton(_ txtColor: Color, _ font: Font) -> some View {
        self.modifier(SSThemeButtonModifier(textColor: txtColor, font: font))
    }
    
}
