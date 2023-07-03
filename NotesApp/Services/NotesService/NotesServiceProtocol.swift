//
//  NotesServiceProtocol.swift
//  NotesApp
//
//  Created by Bruno Bencevic on 28.03.2023..
//

import Foundation

protocol NotesServiceProtocol {
    func getNotes() -> [Note]
    
    func saveNote(_ note: Note) async throws
    func updateNote(id: UUID, title: String, text: String) async throws
    func deleteNote(id: UUID) async throws
    func deleteAllNotes() async throws
    
    func loadNotes(caller: String, line: Int) async throws
    func saveNotes() async throws
    
    func getNotePath(id: UUID) -> String
}
