//
//  AlertDialog.swift
//  NotesApp
//
//  Created by Bruno Bencevic on 07.03.2023..
//

import Foundation

struct AlertDialog: Dialog {
    let id = UUID()
    let title: String
    let message: String?
    let okTitle: String
    let isDismissable: Bool
    let dismissAction: EmptyCallback?
    let action: EmptyCallback?
    
    init(title: String, message: String? = nil, okTitle: String = "OK", isDismissable: Bool = true, dismissAction: EmptyCallback? = nil, action: EmptyCallback? = nil) {
        self.title = title
        self.message = message
        self.okTitle = okTitle
        self.isDismissable = isDismissable
        self.dismissAction = dismissAction
        self.action = action
    }
    
    static func sample() -> AlertDialog {
        .init(title: "Attention!", message: "Thanks for your attention.")
    }
}
