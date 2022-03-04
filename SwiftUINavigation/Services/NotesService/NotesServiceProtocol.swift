//
//  NotesServiceProtocol.swift
//  SwiftUINavigation
//
//  Created by Bruno Benčević on 28.02.2022..
//

import Foundation

protocol NotesServiceProtocol {
    
    var notes: [Note] { get }
    var notesPublished: Published<[Note]> { get }
    var notesPublisher: Published<[Note]>.Publisher { get }
    
    func saveNote(_ note: Note)
    func toggleFavorite(_ noteIndex: Int)
    func deleteNote(noteID: UUID)
}
