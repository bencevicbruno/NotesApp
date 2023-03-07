//
//  MainCoordinator.swift
//  SwiftUINavigation
//
//  Created by Bruno Benčević on 25.02.2022..
//

import Foundation
import SwiftUI

enum MainTab: CaseIterable, Identifiable {
    case notes
    case account
    
    var id: Self {
        self
    }
    
    var title: String {
        switch self {
        case .notes:
            return "Notes"
        case .account:
            return "Account"
        }
    }
    
    var systemImageName: String {
        switch self {
        case .notes:
            return "note.text"
        case .account:
            return "person"
        }
    }
}

final class MainCoordinator: ObservableObject {
    
    @Published var currentTab: MainTab = .notes
    
    @Published var notesCoordinator = NotesCoordinator()
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
        ZStack {
            TabView(selection: $coordinator.currentTab) {
                NotesCoordinatorView(coordinator: coordinator.notesCoordinator)
                    .tag(MainTab.notes)
                
                AccountCoordinatorView(coordinator: coordinator.accountCoordinator)
                    .tag(MainTab.account)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            
            MainTabBar(currentTab: $coordinator.currentTab)
                .frame(maxHeight: .infinity, alignment: .bottom)
        }
        .edgesIgnoringSafeArea(.all)
    }
}
