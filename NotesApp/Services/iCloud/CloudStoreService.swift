//
//  CloudStoreService.swift
//  NotesApp
//
//  Created by Bruno Bencevic on 16.03.2023..
//

import Foundation
import CloudKit

final class CloudStoreService {
    
    static let instance = CloudStoreService()
    
    private let store = NSUbiquitousKeyValueStore()
    
    private init() {
        NotificationCenter.default.addObserver(self, selector: #selector(registerChanges), name: NSUbiquitousKeyValueStore.didChangeExternallyNotification, object: store)
        
        if let token = FileManager.default.ubiquityIdentityToken {
            print("Ubiquity identity: \(token)")
        }
    }
    
    @objc func registerChanges(notification: Notification) {
        if let info = notification.userInfo {
            print("Changes happened on iCloud kVS")
            print(info)
        } else {
            print("No changes happened on iCloud KVS")
        }
    }
    
    func synchronize() {
        if store.synchronize() {
            print("☁️ Synced iCloud KVs")
            NotificationCenter.post(.iCloudUpdated)
        } else {
            print("⚠️ Syncing iCloud KVs failed...")
        }
    }
    
    func loadBool(key: String) -> Bool {
        return store.bool(forKey: key)
    }
    
    func saveBool(_ value: Bool, key: String) {
        store.set(value, forKey: key)
        print("Changed \(key) to \(value)")
        synchronize()
        
    }
    
    func load<T>(key: String = "\(T.self)") -> T? where T: Decodable {
        guard let data = store.data(forKey: key) else {
            print("⚠️ [CloudStoreService] Unable to load \(key).")
            return nil
        }

        guard let t = try? JSONDecoder().decode(T.self, from: data) else {
            print("⚠️ Unable to decode \(key).")
            return nil
        }

        print("✅ Successfully loaded \(key).")
        return t
    }

    func save<T>(_ t: T, key: String = "\(T.self)") where T: Encodable {
        guard let data = try? JSONEncoder().encode(t) else {
            print("⚠️ Unable to save \(key).");
            return
        }

        store.set(data, forKey: key)
        print("✅ Sucessfully saved \(key).")
    }
    
    func delete(key: String) {
        store.removeObject(forKey: key)
    }
}
