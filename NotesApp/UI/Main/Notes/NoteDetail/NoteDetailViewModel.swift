//
//  NoteDetailViewModel.swift
//  SwiftUINavigation
//
//  Created by Bruno Benčević on 28.02.2022..
//

import Foundation
import SwiftUI

final class NoteDetailViewModel: ObservableObject {
    
    @Published var alertDialog: AlertDialog?
    @Published var choiceDialog: ChoiceDialog?
    @Published var confirmationDialog: ConfirmationDialog?
    
    @Published var isActivityRunning = false
    
    let note: Note
    
    @Binding private var navigationPath: NavigationPath
    private var noteService: NotesServiceProtocol = ServiceFactory.notesService
    
    private let mainViewModel = MainViewModel.instance
    
    init(_ note: Note, navigationPath: Binding<NavigationPath>) {
        self.note = note
        self._navigationPath = navigationPath
    }
    
    func dismiss() {
        navigationPath.removeLast()
    }
    
    func showOptions() {
        mainViewModel.choiceDialog = .init(
            title: "Note Actions",
            choices: [
                .init(image: .system("pencil"), title: "Edit"),
                .init(image: .system("heart"), title: "Add to Favorites"),
                .init(image: .system("trash"), title: "Delete"),
                .init(image: .system("square.and.arrow.up"), title: "Share")
            ],
            action: { [weak self] index in
                switch index {
                case 0:
                    self?.showNotImplementedAlert("Editing notes is currently not available!")
                case 1:
                    self?.showNotImplementedAlert("Favoriting notes is currently not available!")
                case 2:
                    self?.showDeletionConfirmation()
                case 3:
                    self?.showNotImplementedAlert("Sharing notes is currently not available!")
                default:
                    print("Unhandled choice index: \(index)")
                }
            })
    }
}

private extension NoteDetailViewModel {
    
    func showDeletionConfirmation() {
        mainViewModel.confirmationDialog = .init(
            title: "Delete Note?",
            message: "This action can not be undone!",
            confirmationTitle: "Delete",
            confirmAction: { [weak self] in
                self?.deleteNote()
            },
            isDissmisable: false)
    }
    
    func showNotImplementedAlert(_ message: String? = nil) {
        mainViewModel.alertDialog = .init(
            title: "Not Implemented",
            message: message)
    }
    
    func deleteNote() {
        Task { @MainActor in
            isActivityRunning = true
            
            do {
                try await noteService.deleteNote(id: note.id)
                navigationPath.removeLast()
            } catch {
                print("Error deleting note: \(error)")
            }
            
            isActivityRunning = false
        }
    }
}
