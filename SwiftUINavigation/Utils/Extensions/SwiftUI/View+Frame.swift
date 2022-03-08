//
//  View+Frame.swift
//  SwiftUINavigation
//
//  Created by Bruno Benčević on 08.03.2022..
//

import SwiftUI

extension View {
    
    func frame(_ size: CGFloat) -> some View {
        self.frame(width: size, height: size)
    }
    
    func maxFrame(width: CGFloat = .infinity, height: CGFloat = .infinity) -> some View {
        self.frame(maxWidth: width, maxHeight: height)
    }
}
