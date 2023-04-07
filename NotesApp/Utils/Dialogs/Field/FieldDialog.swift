//
//  FieldDialog.swift
//  NotesApp
//
//  Created by Bruno Bencevic on 14.03.2023..
//

import Foundation

struct FieldDialog: Dialog {
    let id = UUID()
    let title: String
    let message: String?
    let hint: String
    let okTitle: String
    let isDismissable: Bool
    let dismissAction: EmptyCallback?
    let action: Callback<String>?
    
    init(title: String, message: String? = nil, hint: String = "", okTitle: String = "OK", isDismissable: Bool = true, dismissAction: EmptyCallback? = nil, action: Callback<String>? = nil) {
        self.title = title
        self.message = message
        self.hint = hint
        self.okTitle = okTitle
        self.isDismissable = isDismissable
        self.dismissAction = dismissAction
        self.action = action
    }
    
    static func sample() -> FieldDialog {
        .init(title: "Insert your email.", message: "Gib now. ty. bye", hint: "Email")
    }
}
