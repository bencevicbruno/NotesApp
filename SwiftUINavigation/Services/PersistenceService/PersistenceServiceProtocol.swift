//
//  PersistenceServiceProtocol.swift
//  SwiftUINavigation
//
//  Created by Bruno Benčević on 02.03.2022..
//

import Foundation

protocol PersistenceServiceProtocol {
    
    var savedNotes: [Note] { get set }
    var localUser: LocalUser? { get set }
}
