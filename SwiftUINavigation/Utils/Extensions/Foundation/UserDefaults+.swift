//
//  UserDefaults+.swift
//  SwiftUINavigation
//
//  Created by Bruno Benčević on 02.03.2022..
//

import Foundation

extension UserDefaults {
 
    func load<T>(key: String = "\(T.self)") -> T? where T: Decodable {
        guard let data = self.object(forKey: key) as? Data else {
            print("Unable to load \(key).")
            return nil
        }
        
        guard let t = try? JSONDecoder().decode(T.self, from: data) else {
            print("Unable to decode \(key).")
            return nil
        }
        
        print("Successfully loaded \(key).")
        return t
    }
    
    func save<T>(_ t: T, key: String = "\(T.self)") where T: Encodable {
        guard let data = try? JSONEncoder().encode(t) else {
            print("Unable to save \(key).");
            return
        }
        
        self.set(data, forKey: key)
        print("Sucessfully saved \(key).")
    }
}
