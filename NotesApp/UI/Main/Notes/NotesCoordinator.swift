//
//  NotesCoordinator.swift
//  SwiftUINavigation
//
//  Created by Bruno Benčević on 25.02.2022..
//

import Foundation
import SwiftUI

enum NotesCoordinatorDestination: Hashable {
    case details(Note)
    case create(Note?)
}

struct NotesCoordinatorView: View {
    
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            NotesView(navigationPath: $path)
                .navigationDestination(for: NotesCoordinatorDestination.self) { destination in
                    switch destination {
                    case .details(let note):
                        NoteDetailView(viewModel: .init(note, navigationPath: $path))
                    case .create(let note):
                        NoteNewView(note, navigationPath: $path)
                    }
                }
        }
//        .onChange(of: path) { path in
//            MainCoordinator.instance.isTabBarVisible = path.isEmpty
//        }
    }
}
