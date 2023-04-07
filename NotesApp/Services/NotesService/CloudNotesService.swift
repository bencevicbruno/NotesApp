//
//  CloudNotesService.swift
//  NotesApp
//
//  Created by Bruno Bencevic on 28.03.2023..
//

import Foundation

final class CloudNotesService: ObservableObject, NotesServiceProtocol {
    
    static let instance = CloudNotesService()
    
    @Published
    private(set) var syncingNotesCount: Int = 0
    
    private var cloudNotesTimer: Timer!
    private var notes: [Note] = []
    private var isLoadingNotes = false
    
    private let notesFolder = "notes"
    private let fileService = ServiceFactory.iCloudFileService
    
    private init() {
        setupFolder()
        setupTimer()
    }
    
    func getNotes() -> [Note] {
        return notes
    }
    
    func saveNote(_ note: Note) async throws {
        guard !notes.contains(where: { $0.id == note.id }) else { return }
        try await fileService.writeJSON(note, to: getNotePath(id: note.id))
        
        notes.append(note)
        NotificationCenter.post(.notesUpdated)
    }
    
    func updateNote(id: UUID, title: String, text: String) async throws {
        guard let noteToUpdate = notes.first(where: { $0.id == id }) else { return }
        let newNote = Note(id: id, title: title, text: text, date: noteToUpdate.date, author: noteToUpdate.author)
        
        try await deleteNote(id: id)
        try await saveNote(newNote)
    }
    
    func deleteNote(id: UUID) async throws {
        try fileService.deleteFile(named: getNotePath(id: id))
        notes.removeAll(where: { $0.id == id })
        NotificationCenter.post(.notesUpdated)
    }
    
    func deleteAllNotes() async throws {
        try fileService.deleteFolder(named: notesFolder)
        try fileService.createFolder(named: notesFolder)
        
        notes.removeAll()
        NotificationCenter.post(.notesUpdated)
    }
    
    func loadNotes(caller: String = #file, line: Int = #line) async throws {
        guard !isLoadingNotes else { return }
        isLoadingNotes = true
        notes = []
        
        let fileURLS = try fileService.getFolderContents(of: notesFolder)
        
        for fileURL in fileURLS {
            notes.append(try await fileService.readJSON(from: notesFolder + "/" + fileURL))
        }
        
        isLoadingNotes = false
        NotificationCenter.post(.notesUpdated)
    }
    
    func saveNotes() async throws {
        let notes = notes.map { (getNotePath(id: $0.id), $0) }
        
        for (fileURL, note) in notes {
            try await fileService.writeJSON(note, to: fileURL)
        }
    }
    
    func getNotePath(id: UUID) -> String {
        return notesFolder + "/" + id.uuidString + ".json"
    }
}

private extension CloudNotesService {
    
    // MARK: - Setup
    
    func setupFolder() {
        do {
            try fileService.createFolder(named: notesFolder)
        } catch {
            print("⚠️ Unable to create '\(notesFolder)' folder!")
        }
    }
    
    func setupTimer() {
        cloudNotesTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] timer in
            guard let self else { return }
            
            let allFiles = (try? self.fileService.getFolderContents(of: self.notesFolder)) ?? []
            let newSyncingNotesCount = allFiles.filter { $0.hasSuffix(".icloud") }.count
            
            if (self.syncingNotesCount != 0 && newSyncingNotesCount == 0) {
                Task { @MainActor in
                    try? await self.loadNotes()
                }
            }
            self.syncingNotesCount = newSyncingNotesCount
        }
    }
}
