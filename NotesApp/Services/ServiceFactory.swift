//
//  ServiceFactory.swift
//  SwiftUINavigation
//
//  Created by Bruno Benčević on 28.02.2022..
//

import Foundation

enum ServiceFactory {
    
    static var notesService: NotesServiceProtocol = NotesService()
    
    static var persistenceService: PersistenceServiceProtocol = PersistenceService()
}
