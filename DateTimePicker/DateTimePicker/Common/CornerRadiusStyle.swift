//
//  CornerRadiusStyle.swift
//  DateTimePicker
//
//  Created by Rizwana Desai on 30/11/23.
//

import Foundation
import SwiftUI

struct CornerRadiusStyle: ViewModifier {
    
    //MARK: - Property

    var radius: CGFloat
    var corners: UIRectCorner

    //MARK: - Body
    
    func body(content: Content) -> some View {
        content
            .clipShape(CornerRadiusShape(radius: radius, corners: corners))
    }
    
}

struct CornerRadiusShape: Shape {
    
    //MARK: - Property
    
    var radius = CGFloat.infinity
    var corners = UIRectCorner.allCorners
    
    //MARK: - Methods
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
    
}
