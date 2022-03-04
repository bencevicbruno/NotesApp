//
//  ConfirmationDialog.swift
//  SwiftUINavigation
//
//  Created by Bruno Benčević on 03.03.2022..
//

import Foundation

struct ConfirmationDialog: Identifiable {
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
    
    var id: String {
        title
    }
}
