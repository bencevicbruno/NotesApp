//
//  MainTab.swift
//  SwiftUINavigation
//
//  Created by Bruno Benčević on 25.02.2022..
//

import Foundation

enum MainTab: CaseIterable, Identifiable {
    case notes
    case groups
    case account
    
    var id: Self {
        self
    }
    
    var systemImage: String {
        switch(self) {
        case .notes:
            return "note.text"
        case .groups:
            return "person.3"
        case .account:
            return "gearshape"
        }
    }
    
    var systemImageSelected: String {
        switch(self) {
        case .notes:
            return "note.text"
        case .groups:
            return "person.3.fill"
        case .account:
            return "gearshape.fill"
        }
    }
    
    var title: String {
        switch(self) {
        case .notes:
            return "Notes"
        case .groups:
            return "Groups"
        case .account:
            return "Account"
        }
    }
}
