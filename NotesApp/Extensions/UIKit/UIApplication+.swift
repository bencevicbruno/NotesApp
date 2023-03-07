//
//  UIApplication+.swift
//  SwiftUINavigation
//
//  Created by Bruno Benčević on 28.02.2022..
//

import Foundation
import UIKit

extension UIApplication {
    
    var currentKeyWindow: UIWindow? {
        windows.filter { $0.isKeyWindow }.first
    }
}
