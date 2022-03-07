//
//  NoteShareViewModel.swift
//  SwiftUINavigation
//
//  Created by Bruno Benčević on 28.02.2022..
//

import Foundation

final class NoteShareViewModel: ObservableObject {
    
    private(set) var note: Note
    
    var onDismissed: (() -> Void)?
    var onDismissedToRoot: (() -> Void)?
    
    init(_ note: Note) {
        self.note = note
    }
    
    func dismiss() {
        self.onDismissed?()
    }
    
    func share() {
        self.onDismissedToRoot?()
    }
    
    deinit {
        
    }
}
