//
//  MainCoordinator.swift
//  SwiftUINavigation
//
//  Created by Bruno Benčević on 25.02.2022..
//

import Foundation
import SwiftUI

final class MainCoordinator: ObservableObject {
    
    @Published var currentTab: MainTab = .notes
    
    @Published var notesCoordinator = NotesCoordinator()
    @Published var favoritesCoordinator = FavoritesCoordinator()
    @Published var accountCoordinator = AccountCoordinator()
    
    var onLoggedOut: EmptyCallback?
    
    init() {
        accountCoordinator.onLoggedOut = { [weak self] in
            self?.onLoggedOut?()
        }
    }
}

struct MainCoordinatorView: View {
    
    @ObservedObject var coordinator: MainCoordinator
    
    var body: some View {
        NavigationView {
            TabView(selection: $coordinator.currentTab) {
                NotesCoordinatorView(coordinator: coordinator.notesCoordinator)
                    .tabItem {
                        Label("Notes", systemImage: "note.text")
                    }
                    .tag(MainTab.notes)
                
                FavoritesCoordinatorView(coordinator: coordinator.favoritesCoordinator)
                    .tabItem {
                        Label("Favorites", systemImage: "heart")
                    }
                    .tag(MainTab.favorites)
                
                AccountCoordinatorView(coordinator: coordinator.accountCoordinator)
                    .tabItem {
                        Label("Account", systemImage: "person")
                    }
                    .tag(MainTab.account)
            }
        }
        .navigationViewStyle(.stack)
    }
    
    init(coordinator: MainCoordinator) {
        self.coordinator = coordinator
        
        UITabBar.appearance().backgroundColor = .white
        UITabBar.appearance().tintColor = .blue
        UITabBar.appearance().unselectedItemTintColor = .black
    }
}
