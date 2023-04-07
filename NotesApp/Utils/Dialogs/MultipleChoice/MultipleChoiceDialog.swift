//
//  MultipleChoiceDialog.swift
//  NotesApp
//
//  Created by Bruno Bencevic on 28.03.2023..
//

import Foundation

struct MultipleChoiceDialog: Dialog {
    let id = UUID()
    let title: String
    let message: String?
    var choices: [Choice]
    let cancelTitle: String
    let confirmationTitle: String
    let cancelAction: EmptyCallback?
    let confirmAction: Callback<[Int]>?
    let isDismissable: Bool
    let dismissAction: EmptyCallback?
    
    init(title: String, message: String? = nil, choices: [Choice], cancelTitle: String = "Cancel", confirmationTitle: String = "Confirm", cancelAction: EmptyCallback? = nil, confirmAction: Callback<[Int]>? = nil, isDismissable: Bool = true, dismissAction: EmptyCallback? = nil) {
        self.title = title
        self.message = message
        self.choices = choices
        self.cancelTitle = cancelTitle
        self.confirmationTitle = confirmationTitle
        self.cancelAction = cancelAction
        self.confirmAction = confirmAction
        self.isDismissable = isDismissable
        self.dismissAction = dismissAction
    }
    
    static func sample(long: Bool = false) -> MultipleChoiceDialog {
        if long {
            return .init(
                title: "Whatcha want?",
                message: "Choose watcha want!",
                choices: [
                    .init(title: "Bananas", isSelected: true),
                    .init(title: "Watermelons", isSelected: true),
                    .init(title: "Strawberries", isSelected: true),
                    .init(title: "No Bananas"),
                    .init(title: "Watermelons"),
                    .init(title: "Strawberries")
                ]
            )
        } else {
            return .init(
                title: "Choose an item!",
                message: "Only one item can be chosen!",
                choices: [
                    .init(title: "Add to favorites", isSelected: true),
                    .init(title: "Add to Listen Later", isSelected: true),
                    .init(title: "Share")
                ]
            )
        }
    }
}

extension MultipleChoiceDialog {
    
    struct Choice: Identifiable {
        let id: UUID
        let title: String
        var isSelected: Bool
        
        init(title: String, isSelected: Bool = false) {
            self.id = UUID()
            self.title = title
            self.isSelected = isSelected
        }
    }
}
