//
//  NotesView.swift
//  SwiftUINavigation
//
//  Created by Bruno Benčević on 25.02.2022..
//

import SwiftUI

struct NotesView: View {
    
    @StateObject var viewModel: NotesViewModel
    
    init(navigationPath: Binding<NavigationPath>) {
        self._viewModel = .init(wrappedValue: .init(navigationPath: navigationPath))
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            content
                .padding(.horizontal, 20)
                .padding(.top, NavigationBar.totalHeight + 10)
                .padding(.bottom, MainTabBar.totalHeight + 10)
            
            NavigationBar("Notes")
                .leadingAction(systemImageName: "gearshape", viewModel.interact(.optionsTapped))
                .secondLeadingAction(systemImageName: "ant.fill", viewModel.interact(.debuggingTapped))
                .trailingAction(systemImageName: "plus", viewModel.interact(.createNote))
                .secondTrailingAction(imageName: viewModel.notesFilters.isEmpty ? "icon_filter_empty" : "icon_filter", viewModel.interact(.showFilters))
        }
        .edgesIgnoringSafeArea(.all)
        .background(background)
        .activityIndicatorOverlay(viewModel.isActivityRunning)
        .onNotification(.notesUpdated) { _ in
            print("======= UPDATING NOTES =======")
        }
    }
}

private extension NotesView {
    
    
    // MARK: Background
    var background: some View {
        Image("background_notes")
            .resizable()
            .scaledToFill()
            .blur(radius: 8)
            .frame(width: UIScreen.width, height: UIScreen.height)
    }
    
    // MARK: Content
    @ViewBuilder
    var content: some View {
        VStack(alignment: .leading, spacing: 8) {
            if !viewModel.notesFilters.isEmpty {
                activeFilters
                .transition(.move(edge: .top))
                .animation(.linear, value: viewModel.notesFilters)
            }
            
            // MARK: Empty State
            if viewModel.notes.isEmpty && viewModel.cloudNotes.isEmpty && viewModel.notesNotSynced == 0 {
                EmptyStateCard(title: "No notes", message: "Tap on the + button to make one.", systemImageName: "doc.text.magnifyingglass")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .animation(.linear, value: viewModel.notesFilters)
            } else {
                ScrollView(.vertical) {
                    VStack(alignment: .leading, spacing: 0) {
                        LazyVStack(spacing: 0) {
                            if viewModel.showLocalNotes {
                                localNotesCells
                            }
                            
                            if viewModel.showCloudNotes {
                                cloudNotesCells
                            }
                            
                            if viewModel.notesNotSynced != 0 {
                                notesNotSyncedCard
                            }
                        }
                    }
                    .animation(.linear, value: viewModel.notesFilters)
                }
            }
        }
    }
    
    // MARK: Active Filters
    var activeFilters: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 8) {
                ForEach(viewModel.notesFilters) { filter in
                    HStack(spacing: 4) {
                        Image("icon_x")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                        
                        Text(filter.title)
                            .font(.body)
                            .fontWeight(.medium)
                    }
                    .padding(.vertical, 4)
                    .padding(.horizontal, 8)
                    .background(.thinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .contentShape(RoundedRectangle(cornerRadius: 8))
                    .onTapGesture {
                        viewModel.notesFilters.removeAll(where: { $0 == filter })
                    }
                }
            }
        }
    }
    
    // MARK: Local Notes
    var localNotesCells: some View {
        ForEach(viewModel.notes.filter { _ in viewModel.notesFilters.contains(.favorites) ? false : true }) { note in
            NoteCell(note)
                .onTapGesture {
                    viewModel.interact(.goToNoteDetails(note))
                }
                .padding(.vertical, 8)
        }
    }
    
    // MARK: Cloud notes
    var cloudNotesCells: some View {
        ForEach(viewModel.cloudNotes.filter { _ in viewModel.notesFilters.contains(.favorites) ? false : true }) { note in
            NoteCell(note, isFromCloud: true)
                .onTapGesture {
                    viewModel.interact(.goToNoteDetails(note))
                }
                .padding(.vertical, 8)
        }
    }
    
    // MARK: Notes not synced
    var notesNotSyncedCard: some View {
        Text("Not synced: \(viewModel.notesNotSynced)")
            .frame(maxWidth: .infinity)
            .padding()
            .background(.thinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

struct NotesView_Previews: PreviewProvider {
    
    static var previews: some View {
        NotesView(navigationPath: .constant(.init()))
            .previewDevice(PreviewDevice(rawValue: "iPhone SE (2nd generation)"))
    }
}
