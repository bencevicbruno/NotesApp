//
//  MainTab.swift
//  SwiftUINavigation
//
//  Created by Bruno Benčević on 25.02.2022..
//

import Foundation

enum MainTab: CaseIterable, Identifiable {
    case notes
    case favorites
    case account
    
    var id: Self {
        self
    }
    
    var systemImage: String {
        switch(self) {
        case .notes:
            return "note.text"
        case .favorites:
            return "heart"
        case .account:
            return "person"
        }
    }
    
    var systemImageSelected: String {
        switch(self) {
        case .notes:
            return "note.text"
        case .favorites:
            return "heart.fill"
        case .account:
            return "person.fill"
        }
    }
    
    var title: String {
        switch(self) {
        case .notes:
            return "Notes"
        case .favorites:
            return "Favorites"
        case .account:
            return "Account"
        }
    }
}
