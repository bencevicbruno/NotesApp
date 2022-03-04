//
//  UIScreen+.swift
//  SwiftUINavigation
//
//  Created by Bruno Benčević on 25.02.2022..
//

import Foundation
import UIKit

extension UIScreen {
    
    var topSafeAreaPadding: CGFloat {
        UIApplication.shared.currentKeyWindow?.safeAreaInsets.top ?? 0
    }
    
    var bottomSafeAreaPadding: CGFloat {
        UIApplication.shared.currentKeyWindow?.safeAreaInsets.bottom ?? 0
    }
}
