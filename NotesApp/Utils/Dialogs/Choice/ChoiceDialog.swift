//
//  ChoiceDialog.swift
//  NotesApp
//
//  Created by Bruno Bencevic on 08.03.2023..
//

import Foundation

struct ChoiceDialog: Dialog {
    let id = UUID()
    let title: String
    let message: String?
    let choices: [Choice]
    let isDismissable: Bool
    let dismissAction: EmptyCallback?
    let action: Callback<Int>
    
    init(title: String, message: String? = nil, choices: [Choice], isDismissable: Bool = true, dismissAction: EmptyCallback? = nil, action: @escaping Callback<Int>) {
        self.title = title
        self.message = message
        self.choices = choices
        self.isDismissable = isDismissable
        self.dismissAction = dismissAction
        self.action = action
    }
    
    static func sample() -> ChoiceDialog {
        .init(title: "Choose an item!",
              message: "Only one item can be chosen!",
              choices: [.init(image: .system("heart.fill"),
                              title: "Add to favorites"),
                        .init(image: .system("play.rectangle.on.rectangle.fill"), title: "Add to Listen Later"),
                        .init(image: .system("square.and.arrow.up"), title: "Share")
              ],
              action: { _ in })
    }
}

extension ChoiceDialog {
    
    struct Choice: Identifiable {
        let id = UUID()
        let image: ImageType
        let title: String
    }
}
