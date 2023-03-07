//
//  NotesCoordinator.swift
//  SwiftUINavigation
//
//  Created by Bruno Benčević on 25.02.2022..
//

import Foundation
import SwiftUI

final class NotesCoordinator: ObservableObject {
    
    @Published var viewModel = NotesViewModel(notesService: ServiceFactory.notesService)
    
    @Published var noteDetailViewModel: NoteDetailViewModel?
    @Published var noteShareViewModel: NoteShareViewModel?
    @Published var noteNewViewModel: NoteNewViewModel?
    
    init() {
        viewModel.onGoToDetail = { [weak self] note in
            self?.goToDetail(note: note)
        }
        
        viewModel.onGoToNewNote = { [weak self] in
            self?.goToNewNote()
        }
    }
    
    func goToDetail(note: Note) {
        self.noteDetailViewModel = NoteDetailViewModel(note, noteService: ServiceFactory.notesService)
        
        self.noteDetailViewModel?.onDismissed = { [weak self] in
            self?.noteDetailViewModel = nil
        }
        
        self.noteDetailViewModel?.onShareTapped = { [weak self] in
            self?.goToShare(note: note)
        }
    }
    
    func goToShare(note: Note) {
        self.noteShareViewModel = NoteShareViewModel(note)
        
        self.noteShareViewModel?.onDismissed = { [weak self] in
            self?.noteShareViewModel = nil
        }
        
        self.noteShareViewModel?.onDismissedToRoot = { [weak self] in
            self?.noteDetailViewModel = nil
            self?.noteShareViewModel = nil
        }
    }
    
    func goToNewNote() {
        self.noteNewViewModel = NoteNewViewModel(notesService: ServiceFactory.notesService)
        
        noteNewViewModel?.onDismissed = { [weak self] in
            self?.noteNewViewModel = nil
        }
    }
}

struct NotesCoordinatorView: View {
    
    @ObservedObject var coordinator: NotesCoordinator
    
    var body: some View {
        NotesView(viewModel: coordinator.viewModel)
            .removeNavigationBar()
            .pushNavigation(item: $coordinator.noteDetailViewModel) { viewModel in
                NoteDetailView(viewModel: viewModel)
            }
            .presentNavigation(item: $coordinator.noteShareViewModel) { viewModel in
                NoteShareView(viewModel: viewModel)
            }
            .presentNavigation(item: $coordinator.noteNewViewModel) { viewModel in
                NoteNewView(viewModel: viewModel)
            }
    }
}
