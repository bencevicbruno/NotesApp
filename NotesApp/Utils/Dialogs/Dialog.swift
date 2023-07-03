//
//  Dialog.swift
//  NotesApp
//
//  Created by Bruno Bencevic on 07.03.2023..
//

import Foundation

protocol Dialog: Identifiable, Equatable {
    var id: UUID { get }
    var isDismissable: Bool { get }
    var dismissAction: EmptyCallback? { get }
}

extension Dialog {
    
    static func ==(lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
}
