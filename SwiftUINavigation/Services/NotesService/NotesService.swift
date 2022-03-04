//
//  NotesService.swift
//  SwiftUINavigation
//
//  Created by Bruno Benčević on 28.02.2022..
//

import Foundation

final class NotesService: NotesServiceProtocol {
    
    @Published var notes: [Note] = []
    var notesPublished: Published<[Note]> { _notes }
    var notesPublisher: Published<[Note]>.Publisher { $notes }
    
    init() {
        self.notes = ServiceFactory.persistenceService.savedNotes
        
        if notes.isEmpty {
            addBoilerplateNotes()
        }
        
        self.notes.sort(by: { $0.title < $1.title })
    }
    
    func saveNote(_ note: Note) {
        notes.append(note)
        ServiceFactory.persistenceService.savedNotes = notes
    }
    
    func toggleFavorite(_ noteIndex: Int) {
        notes[noteIndex].isFavorite.toggle()
    }
    
    func deleteNote(noteID: UUID) {
        notes.removeAll(where: { $0.id == noteID })
        ServiceFactory.persistenceService.savedNotes = notes
    }
}


private extension NotesService {
    
    func addBoilerplateNotes() {
        notes.append(Note(title: "Bible",
                          description: "The Holy book of christians",
                          text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                          date: Date(timeIntervalSince1970: 0),
                          isFavorite: true,
                          author: "People"))
        
        notes.append(Note(title: "Apples",
                          description: "A discussion between Steve Jobs & Isaac Newton",
                          text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                          date: Date(timeIntervalSince1970: 23456678),
                          isFavorite: false,
                          author: "Bill Gates"))
    }
    
}
