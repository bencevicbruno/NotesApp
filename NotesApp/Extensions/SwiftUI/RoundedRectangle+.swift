//
//  RoundedRectangle+.swift
//  SwiftUINavigation
//
//  Created by Bruno Benčević on 25.02.2022..
//

import Foundation
import SwiftUI

extension RoundedRectangle {
    
    static func rounded(_ material: Material, top: CGFloat = 0.0, bottom: CGFloat = 0.0) -> some View {
        return RoundedCornerRectangle(radius: top, corner: .topLeft)
            .fill(material)
            .clipShape(RoundedCornerRectangle(radius: top, corner: .topRight))
            .clipShape(RoundedCornerRectangle(radius: bottom, corner: .bottomLeft))
            .clipShape(RoundedCornerRectangle(radius: bottom, corner: .bottomRight))
    }
    
    static func rounded(_ material: Material, topLeft: CGFloat = 0.0, topRight: CGFloat = 0.0, bottomLeft: CGFloat = 0.0, bottomRight: CGFloat = 0.0) -> some View {
        return RoundedCornerRectangle(radius: topLeft, corner: .topLeft)
            .fill(material)
            .clipShape(RoundedCornerRectangle(radius: topRight, corner: .topRight))
            .clipShape(RoundedCornerRectangle(radius: bottomLeft, corner: .bottomLeft))
            .clipShape(RoundedCornerRectangle(radius: bottomRight, corner: .bottomRight))
    }
    
    static func rounded(_ color: Color, top: CGFloat = 0.0, bottom: CGFloat = 0.0) -> some View {
        return RoundedCornerRectangle(radius: top, corner: .topLeft)
            .fill(color)
            .clipShape(RoundedCornerRectangle(radius: top, corner: .topRight))
            .clipShape(RoundedCornerRectangle(radius: bottom, corner: .bottomLeft))
            .clipShape(RoundedCornerRectangle(radius: bottom, corner: .bottomRight))
    }
    
    static func rounded(_ color: Color, topLeft: CGFloat = 0.0, topRight: CGFloat = 0.0, bottomLeft: CGFloat = 0.0, bottomRight: CGFloat = 0.0) -> some View {
        return RoundedCornerRectangle(radius: topLeft, corner: .topLeft)
            .fill(color)
            .clipShape(RoundedCornerRectangle(radius: topRight, corner: .topRight))
            .clipShape(RoundedCornerRectangle(radius: bottomLeft, corner: .bottomLeft))
            .clipShape(RoundedCornerRectangle(radius: bottomRight, corner: .bottomRight))
    }
}
