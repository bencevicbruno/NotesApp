//
//  NoteNewViewModel.swift
//  SwiftUINavigation
//
//  Created by Bruno Benčević on 01.03.2022..
//

import Foundation
import SwiftUI

final class NoteNewViewModel: ObservableObject {
    
    @Published var title: String
    @Published var text: String
    
    @Published var alertDialog: AlertDialog?
    @Published var choiceDialog: ChoiceDialog?
    @Published var secondChoiceDialog: ChoiceDialog?
    @Published var confirmationDialog: ConfirmationDialog?
    
    @Published var isActivityRunning = false
    
    let note: Note?
    
    var onDismissed: EmptyCallback?
    
    @Binding private var navigationPath: NavigationPath
    
    private var notesService: NotesServiceProtocol = ServiceFactory.notesService
    private var cloudNotesService = CloudNotesService.instance
    private let mainViewModel = MainViewModel.instance
    
    init(_ note: Note? = nil, navigationPath: Binding<NavigationPath>) {
        self.note = note
        self._navigationPath = navigationPath
        self.title = note?.title ?? ""
        self.text = note?.text ?? ""
    }
    
    deinit {
        print("NoteNewViewModel deinit")
    }
    
    // MARK: - User Interactions
    
    func dismiss() {
        if !title.isEmpty || !text.isEmpty {
            mainViewModel.confirmationDialog = .init(title: note == nil ? "Discard Note?" : "Discard Changes?", message: "Everything you wrote will be deleted and can not be brought back.", confirmationTitle: "Discard", confirmAction: { [weak self] in
                self?.navigationPath.removeLast()
            })
            return
        }
        
        self.navigationPath.removeLast()
    }
    
    func save() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        
        if title.isEmpty {
            mainViewModel.alertDialog = .init(title: "Title can not be empty!")
            return
        }
        
        mainViewModel.choiceDialog = .init(
            title: "Save Note",
            message: "Where do you want to save this note?",
            choices: [
                .init(image: .system("iphone"), title: "Local"),
                .init(image: .system("folder"), title: "iCloud Drive"),
                .init(image: .system("icloud"), title: "iCloud Database")
            ],
            isDismissable: false) { [weak self] index in
                switch index {
                case 0:
                    self?.saveNoteLocally()
                case 1:
                    self?.saveNoteToICloud()
                case 2:
                    self?.showCloudSaveChoices()
                default:
                    fatalError("Unhandled choice index #\(index)")
                }
            }
    }
    
    func saveNoteLocally() {
        Task { @MainActor in
            isActivityRunning = true
            
            do {
                if let note {
                    try await notesService.updateNote(id: note.id, title: title, text: text)
                } else {
                    try await notesService.saveNote(.init(id: .init(), title: title, text: text, date: .now, author: "Me"))
                }
                self.navigationPath.removeLast()
            } catch {
                print("Error saving note locally: \(error)")
            }
            
            isActivityRunning = false
        }
    }
    
    func saveNoteToICloud() {
        Task { @MainActor in
            isActivityRunning = true
            
            do {
                if let note {
                    try await cloudNotesService.updateNote(id: note.id, title: title, text: text)
                } else {
                    try await cloudNotesService.saveNote(.init(id: .init(), title: title, text: text, date: .now, author: "Me"))
                }
                self.navigationPath.removeLast()
            } catch {
                print("Error saving note to cloud: \(error)")
            }
            
            isActivityRunning = false
        }
    }
    
    func showCloudSaveChoices() {
        mainViewModel.secondChoiceDialog = .init(
            title: "Choose privacy",
            choices: [
                .init(image: .system("lock"), title: "Private"),
                .init(image: .system("globe"), title: "Public"),
                .init(image: .system("person.2.fill"), title: "Shared")
            ]) { index in
                switch index {
                case 0:
                    break
                case 1:
                    break
                case 2:
                    break
                default:
                    fatalError("Unhandled choice index #\(index)")
                }
            }
    }
}
