//
//  ConfirmationDialog.swift
//  SwiftUINavigation
//
//  Created by Bruno Benčević on 03.03.2022..
//

import Foundation
import SwiftUI

struct ConfirmationDialog {
    let title: String
    let message: String?
    let cancelTitle: String
    let confirmationTitle: String
    let cancelAction: EmptyCallback?
    let confirmAction: EmptyCallback?
    
    init(title: String, message: String? = nil, cancelTitle: String = "Cancel", confirmationTitle: String = "Confirm", cancelAction: EmptyCallback? = nil, confirmAction: EmptyCallback? = nil) {
        self.title = title
        self.message = message
        self.cancelTitle = cancelTitle
        self.confirmationTitle = confirmationTitle
        self.cancelAction = cancelAction
        self.confirmAction = confirmAction
    }
}

extension View {
    
    func confirmationDialog(_ confirmationDialog: Binding<ConfirmationDialog?>) -> some View {
        let isVisible = Binding(
            get: { confirmationDialog.wrappedValue != nil },
            set: { value in
                if !value {
                    confirmationDialog.wrappedValue = nil
                }
            }
        )
        
        return ZStack {
            self
            
            if let dialog = confirmationDialog.wrappedValue {
                ConfirmationDialogView(isVisible, dialog: dialog)
            }
        }
    }
}

