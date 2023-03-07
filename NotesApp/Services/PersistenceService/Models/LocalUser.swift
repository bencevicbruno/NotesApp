//
//  LocalUser.swift
//  SwiftUINavigation
//
//  Created by Bruno Benčević on 02.03.2022..
//

import Foundation

struct LocalUser: Identifiable, Codable {
    let id: UUID
    var name: String
    var lastName: String
    var email: String
    
    init(name: String, lastName: String, email: String) {
        id = UUID()
        self.name = name
        self.lastName = lastName
        self.email = email
    }
}
