//
//  Dialog.swift
//  SwiftUINavigation
//
//  Created by Bruno Benčević on 05.03.2022..
//

import Foundation
import SwiftUI

struct Dialog {
    let title: String
    let message: String?
    let okTitle: String
    let okAction: EmptyCallback?
    
    init(title: String, message: String? = nil, okTitle: String = "OK", okAction: EmptyCallback? = nil) {
        self.title = title
        self.message = message
        self.okTitle = okTitle
        self.okAction = okAction
    }
}

extension View {
    
    func dialog(_ dialog: Binding<Dialog?>) -> some View {
        let isVisible = Binding(
            get: { dialog.wrappedValue != nil },
            set: { value in
                if !value {
                    dialog.wrappedValue = nil
                }
            }
        )
        
        return ZStack {
            self
            
            if let dialog = dialog.wrappedValue {
                DialogView(isVisible, dialog: dialog)
            }
        }
    }
}

