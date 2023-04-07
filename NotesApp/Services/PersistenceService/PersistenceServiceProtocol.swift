//
//  PersistenceServiceProtocol.swift
//  SwiftUINavigation
//
//  Created by Bruno Benčević on 02.03.2022..
//

import Foundation

protocol PersistenceServiceProtocol {
    
    var lockNotes: Bool { get set }
    var savedNotes: [Note] { get set }
    var localUser: LocalUser? { get set }
}
