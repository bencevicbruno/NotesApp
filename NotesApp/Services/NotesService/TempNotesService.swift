//
//  TempNotesService.swift
//  NotesApp
//
//  Created by Bruno Bencevic on 28.03.2023..
//

import Foundation

final class TempNotesService: NotesServiceProtocol {
    
    private var notes = [Note]()
    
    func getNotes() -> [Note] {
        return notes
    }
    
    func saveNote(_ note: Note) async throws {
        guard !notes.contains(where: { $0.id == note.id }) else { return }
        notes.append(note)
    }
    
    func updateNote(id: UUID, title: String, text: String) async throws {
        guard let note = notes.first(where: { $0.id == id }) else { return }
        try await deleteNote(id: id)
        let newNote = Note(id: id, title: title, text: text, date: note.date, author: note.author)
        notes.append(newNote)
    }
    
    func deleteNote(id: UUID) async throws {
        notes.removeAll(where: { $0.id == id })
    }
    
    func deleteAllNotes() async throws {
        notes.removeAll()
    }
    
    func loadNotes(caller: String, line: Int) async throws {
        return
    }
    
    func saveNotes() async throws {
        return
    }
    
    func getNotePath(id: UUID) -> String {
        return ""
    }
}
