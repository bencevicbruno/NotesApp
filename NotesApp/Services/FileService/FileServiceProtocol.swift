//
//  FileServiceProtocol.swift
//  NotesApp
//
//  Created by Bruno Bencevic on 28.03.2023..
//

import Foundation

protocol FileServiceProtocol {
    func deleteFile(named fileName: String) throws
    func deleteFile(at url: URL) throws
    
    func createFolder(named folderName: String) throws
    func createFolder(at url: URL) throws
    
    func getFolderContents(of url: String) throws -> [String]
    func getFolderContents(at url: URL) throws -> [URL]
    
    func deleteFolder(named folderName: String) throws
    func deleteFolder(at url: URL) throws
    
    func readData(form url: String) async throws -> Data
    func readData(from url: URL) async throws -> Data
    func writeData(_ data: Data, to url: String) async throws
    func writeData(_ data: Data, to url: URL) async throws
    
    func readJSON<T>(from url: String) async throws -> T where T: Decodable
    func readJSON<T>(from url: URL) async throws -> T where T: Decodable
    func writeJSON<T>(_ t: T, to url: String) async throws where T: Encodable
    func writeJSON<T>(_ t: T, to url: URL) async throws where T: Encodable
}
