//
//  NoteNewViewModel.swift
//  SwiftUINavigation
//
//  Created by Bruno Benčević on 01.03.2022..
//

import Foundation
import SwiftUI

final class NoteNewViewModel: ObservableObject {
    
    @Published var title = ""
    @Published var description = ""
    @Published var text = ""
    @Published var isFavorite = false
    @Published var author = ""
    @Published var isShowingDialog = false
    
    var onDismissed: EmptyCallback?
    
    var notesService: NotesServiceProtocol
    
    init(notesService: NotesServiceProtocol) {
        self.notesService = notesService
    }
    
    func saveNote() {
        let note = Note(title: title, description: description, text: text, date: Date(), isFavorite: isFavorite, author: author)
        notesService.saveNote(note)
        
        
        isShowingDialog.toggle()
        
        self.onDismissed?()
    }
    
    func dismiss() {
        self.onDismissed?()
    }
    
    func presentDialog() {
        withAnimation {
            isShowingDialog.toggle()
        }
    }
}
