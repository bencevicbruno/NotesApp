//
//  UIScreen+.swift
//  SwiftUINavigation
//
//  Created by Bruno Benčević on 25.02.2022..
//

import Foundation
import UIKit

extension UIScreen {
    
    static let width = UIScreen.main.bounds.width
    
    static let height = UIScreen.main.bounds.height
    
    static var isSmall: Bool {
        Self.width <= 320
    }
    
    static let unsafeTopPadding: CGFloat = UIApplication.shared.windows.first?.safeAreaInsets.top ?? 60
    
    static let unsafeBottomPadding: CGFloat = UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 20
}
