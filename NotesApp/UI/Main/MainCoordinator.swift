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
    case cloud
    case account
    
    var id: Self {
        self
    }
    
    var title: String {
        switch self {
        case .notes:
            return "Notes"
        case .cloud:
            return "Cloud"
        case .account:
            return "Account"
        }
    }
    
    func systemImageName(isSelected: Bool) -> String {
        switch self {
        case .notes:
            return "doc.plaintext" + (isSelected ? ".fill" : "")
        case .cloud:
            return "externaldrive.fill.badge.icloud"
        case .account:
            return "person" + (isSelected ? ".fill" : "")
        }
    }
}

final class MainCoordinator: ObservableObject {
    
    @Published var currentTab: MainTab = .notes
    @Published var isTabBarVisible = true
    
//    @Published var notesCoordinator = NotesCoordinator()
    @Published var accountCoordinator = AccountCoordinator()
    
    var onLoggedOut: EmptyCallback?
    
    static let instance = MainCoordinator()
    
    private init() {
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
                NotesCoordinatorView()
                    .tag(MainTab.notes)
                
                CloudCoordinatorView()
                    .tag(MainTab.cloud)
                
                AccountCoordinatorView(coordinator: coordinator.accountCoordinator)
                    .tag(MainTab.account)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            
            if coordinator.isTabBarVisible {
                MainTabBar(currentTab: $coordinator.currentTab)
                    .shadow(radius: 16)
                    .frame(maxHeight: .infinity, alignment: .bottom)
                    .transition(.move(edge: .bottom))
                    .animation(.linear(duration: 0.3), value: coordinator.isTabBarVisible)
            }
        }
        .edgesIgnoringSafeArea(.all)
        .animation(.linear(duration: 0.4), value: coordinator.currentTab)
    }
}
