//
//  ShareNoteViewModel.swift
//  SwiftUINavigation
//
//  Created by Bruno Benčević on 28.02.2022..
//

import Foundation

final class ShareNoteViewModel: ObservableObject {
    
    private(set) var note: Note
    
    var onDismissed: (() -> Void)?
    var onDismissedToRoot: (() -> Void)?
    
    init(_ note: Note) {
        self.note = note
    }
    
    // MARK: - Interaction
    
    func xTapped() {
        self.onDismissed?()
    }
    
    func shareTapped() {
        self.onDismissedToRoot?()
    }
}
