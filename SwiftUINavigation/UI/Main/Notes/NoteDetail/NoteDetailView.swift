//
//  NoteDetailView.swift
//  SwiftUINavigation
//
//  Created by Bruno Benčević on 28.02.2022..
//

import SwiftUI

struct NoteDetailView: View {
    
    @ObservedObject var viewModel: NoteDetailViewModel
    
    var body: some View {
        Form {
            Section {
                Text(noteDate)
            } header: {
                Text("Date written")
            }
            
            Section {
                Text(viewModel.note.text)
            } header: {
                Text("Contents")
            }
            
            Button("Share") { [weak viewModel] in
                viewModel?.share()
            }
        }
        .navigationTitle(viewModel.note.title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    viewModel.showDeleteDialog()
                } label: {
                    Image(systemName: "trash")
                }
            }
        }
        .confirmationDialog($viewModel.deleteConfirmation)
    }
    
    var noteDate: String {
        viewModel.note.date.formatted(.dateTime).components(separatedBy: " ").first ?? "unknown"
    }
}

struct NoteDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NoteDetailView(viewModel: NoteDetailViewModel(.test, noteService: ServiceFactory.notesService))
    }
}
