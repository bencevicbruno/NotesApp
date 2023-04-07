//
//  ConfirmationDialog.swift
//  SwiftUINavigation
//
//  Created by Bruno Benčević on 03.03.2022..
//

import Foundation

struct ConfirmationDialog: Dialog {
    let id = UUID()
    let title: String
    let message: String?
    let cancelTitle: String
    let confirmationTitle: String
    let isDismissable: Bool
    let dismissAction: EmptyCallback?
    let cancelAction: EmptyCallback?
    let confirmAction: EmptyCallback?
    
    init(title: String, message: String? = nil, cancelTitle: String = "Cancel", confirmationTitle: String = "Confirm", cancelAction: EmptyCallback? = nil, confirmAction: EmptyCallback? = nil, isDissmisable: Bool = true, dismissAction: EmptyCallback? = nil) {
        self.title = title
        self.message = message
        self.cancelTitle = cancelTitle
        self.confirmationTitle = confirmationTitle
        self.cancelAction = cancelAction
        self.confirmAction = confirmAction
        self.isDismissable = isDissmisable
        self.dismissAction = dismissAction
    }
    
    static func sample() -> ConfirmationDialog {
        .init(title: "Are you sure you want to proceed?", message: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", confirmationTitle: "Yes")
    }
}
