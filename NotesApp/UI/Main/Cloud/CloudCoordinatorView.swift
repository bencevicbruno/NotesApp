//
//  CloudCoordinatorView.swift
//  NotesApp
//
//  Created by Bruno Bencevic on 13.03.2023..
//

import SwiftUI

struct CloudCoordinatorView: View {
    
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            CloudView(navigationPath: $path)
//                .navigationDestination(for: NotesCoordinatorDestination.self) { destination in
//                    switch destination {
//                    case .details(let note):
//                        NoteDetailView(viewModel: .init(note, navigationPath: $path))
//                    case .create(let note):
//                        NoteNewView(note, navigationPath: $path)
//                    }
//                }
        }
        .onChange(of: path) { path in
            MainCoordinator.instance.isTabBarVisible = path.isEmpty
        }
    }
}
