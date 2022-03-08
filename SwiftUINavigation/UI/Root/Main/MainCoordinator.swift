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
    @Published var favoritesCoordinator = GroupsCoordinator()
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
                    .tag(MainTab.notes)
                
                GroupsCoordinatorView(coordinator: coordinator.favoritesCoordinator)
                    .tag(MainTab.groups)
                
                AccountCoordinatorView(coordinator: coordinator.accountCoordinator)
                    .tag(MainTab.account)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .overlay(alignment: .bottom) {
                MainTabBar(currentTab: $coordinator.currentTab)
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
