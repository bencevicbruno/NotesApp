//
//  NotesViewModel.swift
//  SwiftUINavigation
//
//  Created by Bruno Benčević on 25.02.2022..
//

import Foundation
import SwiftUI
import Combine

final class NotesViewModel: ObservableObject {
    
    @Published var notes: [Note] = []
    
    var onGoToDetail: ((Note) -> Void)?
    var onGoToNewNote: EmptyCallback?
    
    private var notesService: NotesServiceProtocol
    
    private var subscribers = Set<AnyCancellable>()
    
    init(notesService: NotesServiceProtocol) {
        self.notesService = notesService
        
        setupSubscribers()
    }
    
    func goToDetail(noteIndex: Int) {
        self.onGoToDetail?(notes[noteIndex])
    }
    
    func toggleFavorite(noteIndex: Int) {
        notesService.toggleFavorite(noteIndex)
    }
    
    func goToNewNote() {
        self.onGoToNewNote?()
    }
}

private extension NotesViewModel {
    
    func setupSubscribers() {
        self.notesService.notesPublisher
            .sink { [weak self] notes in
                self?.notes = notes
            }
            .store(in: &subscribers)
    }
}
