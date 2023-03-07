//
//  ConfirmationDialog.swift
//  SwiftUINavigation
//
//  Created by Bruno Benčević on 03.03.2022..
//

import Foundation

protocol Dialog: Identifiable, Equatable {
    var id: UUID { get }
    
    var dismissAction: EmptyCallback? { get }
}

extension Dialog {
    
    static func ==<D1>(lhs: Self, rhs: D1) -> Bool where D1: Dialog {
        lhs.id == rhs.id
    }
}

struct AlertDialog: Dialog {
    let id = UUID()
    let title: String
    let message: String?
    let okTitle: String
    let dismissAction: EmptyCallback?
    let action: EmptyCallback?
    
    init(title: String, message: String? = nil, okTitle: String = "OK", dismissAction: EmptyCallback? = nil, action: EmptyCallback? = nil) {
        self.title = title
        self.message = message
        self.okTitle = okTitle
        self.dismissAction = dismissAction
        self.action = action
    }
    
    
}

struct ConfirmationDialog: Dialog {
    
    let id = UUID()
    let title: String
    let message: String?
    let cancelTitle: String
    let confirmationTitle: String
    let dismissAction: EmptyCallback?
    let cancelAction: EmptyCallback?
    let confirmAction: EmptyCallback?
    
    init(title: String, message: String? = nil, cancelTitle: String = "Cancel", confirmationTitle: String = "Confirm", cancelAction: EmptyCallback? = nil, confirmAction: EmptyCallback? = nil, dismissAction: EmptyCallback? = nil) {
        self.title = title
        self.message = message
        self.cancelTitle = cancelTitle
        self.confirmationTitle = confirmationTitle
        self.cancelAction = cancelAction
        self.confirmAction = confirmAction
        self.dismissAction = dismissAction
    }
}
