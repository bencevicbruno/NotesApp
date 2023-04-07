//
//  PersistenceService.swift
//  SwiftUINavigation
//
//  Created by Bruno Benčević on 02.03.2022..
//

import Foundation

final class PersistenceService: PersistenceServiceProtocol {
    
    var lockNotes: Bool {
        get {
            CloudStoreService.instance.loadBool(key: "lockNotes")
        } set {
            CloudStoreService.instance.saveBool(newValue, key: "lockNotes")
        }
    }
    
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
            UserDefaults.standard.save(newValue, key: "local_user")
        }
    }
}
