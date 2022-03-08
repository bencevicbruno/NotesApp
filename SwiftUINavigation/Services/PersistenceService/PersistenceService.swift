//
//  PersistenceService.swift
//  SwiftUINavigation
//
//  Created by Bruno Benčević on 02.03.2022..
//

import Foundation

final class PersistenceService: PersistenceServiceProtocol {
    
    var savedNotes: [Note] {
        get {
            UserDefaults.standard.load(.savedNotes) ?? []
        }
        set {
            UserDefaults.standard.save(newValue, .savedNotes)
        }
    }
    
    var localUser: LocalUser? {
        get {
            UserDefaults.standard.load(.localUser)
        }
        set {
            UserDefaults.standard.save(newValue, .localUser)
        }
    }
    
    var keepUserLoggedIn: Bool {
        get {
            UserDefaults.standard.load(.keepUserLoggedIn) ?? false
        }
        set {
            UserDefaults.standard.save(newValue, .keepUserLoggedIn)
        }
    }
}
