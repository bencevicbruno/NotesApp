//
//  NoteDetailViewModel.swift
//  SwiftUINavigation
//
//  Created by Bruno Benčević on 28.02.2022..
//

import Foundation
import SwiftUI

final class NoteDetailViewModel: ObservableObject {
    
    @Published var deleteConfirmation: ConfirmationDialog?
    
    private(set) var note: Note
    
    var noteService: NotesServiceProtocol
    
    var onDismissed: (() -> Void)?
    var onShareTapped: (() -> Void)?
    
    init(_ note: Note, noteService: NotesServiceProtocol) {
        self.note = note
        self.noteService = noteService
    }
    
    func dismiss() {
        onDismissed?()
    }
    
    func share() {
        onShareTapped?()
    }
    
    func deleteNote() {
        noteService.deleteNote(noteID: note.id)
        onDismissed?()
    }
    
    func showDeleteDialog() {
        withAnimation {
            self.deleteConfirmation = ConfirmationDialog(
                title: "Delete Note",
                message: "Are you sure you want to delete \(note.title)?",
                confirmAction: { [weak self] in
                    self?.deleteNote()
                }
            )
        }
    }
    
    deinit {
        print("Deinit \(Self.self)")
    }
}
