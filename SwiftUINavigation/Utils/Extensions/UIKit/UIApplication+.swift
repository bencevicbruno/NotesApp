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
        if #available(iOS 15, *) {
            return UIApplication.shared.connectedScenes
                .filter { $0.activationState == .foregroundActive }
                .first(where: { $0 is UIWindowScene })
                .flatMap { $0 as? UIWindowScene }?.windows
                .first(where: { $0.isKeyWindow })
        } else {
            return windows.filter { $0.isKeyWindow }.first
        }
    }
}
