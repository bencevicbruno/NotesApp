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
            UserDefaults.standard.load() ?? []
        }
        set {
            UserDefaults.standard.save(newValue)
        }
    }
    
    var localUser: LocalUser? {
        get {
            UserDefaults.standard.load(key: "local_user")
        }
        set {
            print(newValue)
            UserDefaults.standard.save(newValue, key: "local_user")
        }
    }
}
