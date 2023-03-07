//
//  RoundedCornerRectangle.swift
//  SwiftUINavigation
//
//  Created by Bruno Benčević on 25.02.2022..
//

import Foundation
import SwiftUI

struct RoundedCornerRectangle: Shape {
    
    var radius: CGFloat = 0.0
    var corner: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        return Path(UIBezierPath(roundedRect: rect, byRoundingCorners: [corner], cornerRadii: CGSize(width: radius, height: radius)).cgPath)
    }
}
