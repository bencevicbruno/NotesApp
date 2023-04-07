//
//  ServiceFactory.swift
//  SwiftUINavigation
//
//  Created by Bruno Benčević on 28.02.2022..
//

import Foundation

enum ServiceFactory {
    
    static var tempNotesService: NotesServiceProtocol = TempNotesService()
    static var notesService: NotesService = NotesService.instance
    static var cloudNotesService: CloudNotesService = CloudNotesService.instance
    
    static var persistenceService: PersistenceServiceProtocol = PersistenceService()
    
    static var fileService: FileServiceProtocol = FileService(.local)
    static var iCloudFileService: FileServiceProtocol = FileService(.iCloud)
}
