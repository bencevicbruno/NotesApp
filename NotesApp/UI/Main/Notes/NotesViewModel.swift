//
//  NotesViewModel.swift
//  SwiftUINavigation
//
//  Created by Bruno Benčević on 25.02.2022..
//

import SwiftUI
import Combine

enum NotesFilter: Int, Identifiable, CaseIterable {
    case local = 0
    case iCloud = 1
    case favorites = 2
    
    var title: String {
        switch self {
        case .local:
            return "Local"
        case .iCloud:
            return "Cloud"
        case .favorites:
            return "Favorites"
        }
    }
    
    var id: Self {
        self
    }
}

final class NotesViewModel: ObservableObject {
    
    enum Interaction {
        case createNote
        case goToNoteDetails(_ note: Note)
        case optionsTapped
        case debuggingTapped
        case showFilters
    }
    
    @Published var notesFilters: [NotesFilter] = []
    @Published var notes: [Note] = []
    @Published var cloudNotes: [Note] = []
    @Published var isActivityRunning = true
    @Published var notesNotSynced: Int = 0
    
    @Binding private var navigationPath: NavigationPath
    
    private var notesService = ServiceFactory.notesService
    private var cloudNotesService = CloudNotesService.instance
    private var subscribers = Set<AnyCancellable>()
    private var activityCounter = 0 {
        didSet {
            isActivityRunning = activityCounter > 0
        }
    }
    
    private let mainViewModel = MainViewModel.instance
    
    init(navigationPath: Binding<NavigationPath>) {
        self._navigationPath = navigationPath
        
        NotificationCenter.addAction(for: .notesUpdated) { [weak self] in
            DispatchQueue.main.async {
                self?.refreshAllNotes()
            }
        }
        
        loadNotes()
        
        self.cloudNotesService.$syncingNotesCount
            .receive(on: RunLoop.main)
            .sink {
                self.notesNotSynced = $0
            }
            .store(in: &subscribers)
    }
    
    var showLocalNotes: Bool {
        notesFilters.isEmpty || notesFilters.contains(.local)
    }
    
    var showCloudNotes: Bool {
        notesFilters.isEmpty || notesFilters.contains(.iCloud)
    }
    
    func interact(_ interaction: Interaction) {
        switch interaction {
        case .createNote:
            goToNewNote()
        case .goToNoteDetails(let note):
            goToDetail(note)
        case .optionsTapped:
            showOptions()
        case .debuggingTapped:
            showResetConfirmation()
        case .showFilters:
            showFilters()
        }
    }
    
    func goToDetail(_ note: Note) {
        navigationPath.append(NotesCoordinatorDestination.details(note))
    }
    
    
    func goToNewNote() {
        navigationPath.append(NotesCoordinatorDestination.create(nil))
    }
    
    func loadNotes() {
        Task { @MainActor [weak self] in
            self?.activityCounter += 1
            
            do {
                try await self?.notesService.loadNotes(caller: #file, line: #line)
            } catch {
                print("Error loading notes: \(error)")
            }
            
            self?.activityCounter -= 1
        }
        
        Task { @MainActor [weak self] in
            self?.activityCounter += 1
            
            do {
                try await self?.cloudNotesService.loadNotes()
            } catch {
                print("Error loading cloud notes: \(error)")
            }
            
            self?.activityCounter -= 1
        }
    }
}

private extension NotesViewModel {
    
    // MARK: Options
    
    func showOptions() {
        MainViewModel.instance.choiceDialog = .init(
            title: "Options",
            choices: [
                .init(image: .custom("icon_refresh"), title: "Refresh"),
                .init(image: .custom("icon_reload"), title: "Reload"),
                .init(image: .system("trash"), title: "Delete Local Notes"),
                .init(image: .system("icloud.slash.fill"), title: "Delete Cloud Notes")
            ]) { [weak self] index in
                switch index {
                case 0:
                    self?.refreshAllNotes()
                case 1:
                    self?.loadNotes()
                case 2:
                    self?.showDeleteLocalNotesConfirmation()
                case 3:
                    self?.showDeleteCloudNotesConfirmation()
                default:
                    fatalError("Unhandled choice index")
                }
            }
    }
    
    func refreshAllNotes() {
        self.notes = notesService.getNotes()
        self.cloudNotes = cloudNotesService.getNotes()
    }
    
    func showDeleteLocalNotesConfirmation() {
        mainViewModel.confirmationDialog = .init(
            title: "Delete Local Notes?",
            message: "This will wipe out all notes saved on this device.",
            cancelTitle: "Cancel",
            confirmationTitle: "Delete",
            confirmAction: { [weak self] in
                self?.deleteLocalNotes()
            })
    }
    
    func deleteLocalNotes() {
        Task { @MainActor in
            self.activityCounter += 1
            
            do {
                try await notesService.deleteAllNotes()
            } catch {
                print("Error deleting all notes: \(error)")
            }
            
            self.activityCounter -= 1
        }
    }
    
    func showDeleteCloudNotesConfirmation() {
        mainViewModel.confirmationDialog = .init(
            title: "Delete Cloud Notes?",
            message: "This will wipe out all notes saved on cloud.",
            cancelTitle: "Cancel",
            confirmationTitle: "Delete",
            confirmAction: { [weak self] in
                self?.deleteCloudNotes()
            })
    }
    
    func deleteCloudNotes() {
        Task { @MainActor in
            self.activityCounter += 1
            
            do {
                try await cloudNotesService.deleteAllNotes()
            } catch {
                print("Error deleting all cloud notes: \(error)")
            }
            
            self.activityCounter -= 1
        }
    }
    
    // MARK: Storage Reset
    
    func showResetConfirmation() {
        mainViewModel.confirmationDialog = .init(
            title: "Reset Storage?",
            message: "This will wipe out all saved notes.",
            cancelTitle: "Cancel",
            confirmationTitle: "Reset",
            confirmAction: { [weak self] in
                self?.resetStorage()
            })
    }
    
    func resetStorage() {
        Task { @MainActor in
            self.activityCounter += 1
            
            do {
                try await notesService.deleteAllNotes()
                try await cloudNotesService.deleteAllNotes()
            } catch {
                print("Error resetting storage: \(error)")
            }
            
            self.activityCounter -= 1
        }
    }
    
    // MARK: - Filters
    
    func showFilters() {
        mainViewModel.multipleChoiceDialog = .init(
            title: "Filter Notes",
            choices: NotesFilter.allCases.map { .init(title: $0.title, isSelected: self.notesFilters.contains($0)) },
            confirmationTitle: "Select",
            confirmAction: { [weak self] indices in
                self?.notesFilters = indices.compactMap { NotesFilter(rawValue: $0) }
            })
    }
}

