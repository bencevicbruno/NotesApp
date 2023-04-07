//
//  FileService.swift
//  NotesApp
//
//  Created by Bruno Bencevic on 21.03.2023..
//

import Foundation

final class FileService: FileServiceProtocol {
    
    private let type: FileServiceType
    private let fileManager = FileManager.default
    private let jsonDecoder = JSONDecoder()
    private let jsonEncoder = JSONEncoder()
    
    init(_ type: FileServiceType) {
        self.type = type
    }
    
    enum FileServiceType {
        case local
        case iCloud
    }
}

// MARK: - FileIO
extension FileService {
    
    func deleteFile(named fileName: String) throws {
        guard let url = getURL(fileName) else {
            throw FileServiceError.invalidURL(fileName)
        }
        
        if fileManager.fileExists(atPath: url.path, isDirectory: .none) {
            try fileManager.removeItem(atPath: url.path)
            Self.log("Deleted \(fileName)")
        }
    }
    
    func deleteFile(at url: URL) throws {
        if fileManager.fileExists(atPath: url.path, isDirectory: .none) {
            try fileManager.removeItem(atPath: url.path)
            Self.log("Deleted \(url.path(percentEncoded: false))")
        }
    }
}

// MARK: Directory IO
extension FileService {
    
    func createFolder(named folderName: String) throws {
        guard let url = getURL(folderName) else {
            throw FileServiceError.invalidURL(folderName)
        }
        
        if !fileManager.fileExists(atPath: url.path, isDirectory: .none) {
            try fileManager.createDirectory(atPath: url.path, withIntermediateDirectories: true)
            Self.log("Created folder \(folderName)")
        }
    }
    
    func createFolder(at url: URL) throws {
        if !fileManager.fileExists(atPath: url.path, isDirectory: .none) {
            try fileManager.createDirectory(atPath: url.path, withIntermediateDirectories: true)
            Self.log("Created folder \(url.path(percentEncoded: false))")
        }
    }
    
    func getFolderContents(of url: String) throws -> [String] {
        guard let url = getURL(url) else {
            throw FileServiceError.invalidURL(url)
        }
        
        let contents = try fileManager.contentsOfDirectory(atPath: url.path)
        Self.log("Read contents of \(url): \(contents)")
        
        return contents
    }
    
    func getFolderContents(at url: URL) throws -> [URL] {
        let contents = try fileManager.contentsOfDirectory(at: url, includingPropertiesForKeys: nil)
        Self.log("Read contents of \(url.path(percentEncoded: false)): \(contents)")
        
        return contents
    }
    
    func deleteFolder(named folderName: String) throws {
        guard let url = getURL(folderName) else {
            throw FileServiceError.invalidURL(folderName)
        }
        
        if fileManager.fileExists(atPath: url.path, isDirectory: .none) {
            try fileManager.removeItem(atPath: url.path)
            Self.log("Deleted folder \(folderName)")
        }
    }
    
    func deleteFolder(at url: URL) throws {
        if fileManager.fileExists(atPath: url.path, isDirectory: .none) {
            try fileManager.removeItem(atPath: url.path)
            Self.log("Deleted folder \(url.path(percentEncoded: false))")
        }
    }
}

// MARK: Data IO
extension FileService {
    
    func readData(form url: String) async throws -> Data {
        return try await withUnsafeThrowingContinuation { continuation in
            guard let url = getURL(url) else {
                continuation.resume(throwing: FileServiceError.invalidURL(url))
                return
            }
            
            do {
                let data = try Data(contentsOf: url)
                Self.log("Read data: \(String(data: data, encoding: .utf8) ?? "None") from \(url)")
                
                continuation.resume(returning: data)
            } catch {
                continuation.resume(throwing: error)
            }
        }
    }
    
    func readData(from url: URL) async throws -> Data {
        return try await withUnsafeThrowingContinuation { continuation in
            do {
                let data = try Data(contentsOf: url)
                Self.log("Read data: \(String(data: data, encoding: .utf8) ?? "None") from \(url.path(percentEncoded: false))")
                
                continuation.resume(returning: data)
            } catch {
                continuation.resume(throwing: error)
            }
        }
    }
    
    func writeData(_ data: Data, to url: String) async throws {
        return try await withUnsafeThrowingContinuation { continuation in
            guard let url = getURL(url) else {
                continuation.resume(with: .failure(FileServiceError.invalidURL(url)))
                return
            }
            
            do {
                try data.write(to: url)
                Self.log("Written data: \(String(data: data, encoding: .utf8) ?? "None") to \(url)")
                
                continuation.resume()
            } catch {
                continuation.resume(with: .failure(error))
            }
        }
    }
    
    func writeData(_ data: Data, to url: URL) async throws {
        return try await withUnsafeThrowingContinuation { continuation in
            do {
                try data.write(to: url)
                Self.log("Written data: \(String(data: data, encoding: .utf8) ?? "None") to \(url.path(percentEncoded: false))")
                
                continuation.resume()
            } catch {
                continuation.resume(with: .failure(error))
            }
        }
    }
}

// MARK: JSON IO
extension FileService {
    
    func readJSON<T>(from url: String) async throws -> T where T: Decodable {
        return try await withUnsafeThrowingContinuation { continuation in
            guard let url = getURL(url) else {
                continuation.resume(throwing: FileServiceError.invalidURL(url))
                return
            }
            
            do {
                let data = try Data(contentsOf: url)
                Self.log("Read JSON: \(String(data: data, encoding: .utf8) ?? "cant convert") to \(url)")
                
                let t = try jsonDecoder.decode(T.self, from: data)
                Self.log("JSON parsed")
                
                continuation.resume(returning: t)
            } catch {
                continuation.resume(throwing: error)
            }
        }
    }
    
    func readJSON<T>(from url: URL) async throws -> T where T: Decodable {
        return try await withUnsafeThrowingContinuation { continuation in
            do {
                let data = try Data(contentsOf: url)
                Self.log("Read JSON: \(String(data: data, encoding: .utf8) ?? "cant convert") to \(url.path(percentEncoded: false))")
                
                let t = try jsonDecoder.decode(T.self, from: data)
                Self.log("JSON parsed")
                
                continuation.resume(returning: t)
            } catch {
                continuation.resume(throwing: error)
            }
        }
    }
    
    func writeJSON<T>(_ t: T, to url: String) async throws where T: Encodable {
        return try await withUnsafeThrowingContinuation { continuation in
            guard let url = getURL(url) else {
                continuation.resume(with: .failure(FileServiceError.invalidURL(url)))
                return
            }
            
            do {
                let data = try jsonEncoder.encode(t)
                Self.log("Writing JSON \(String(data: data, encoding: .utf8) ?? "cant parse") to \(url)")
                
                try data.write(to: url)
                Self.log("JSON written")
                
                continuation.resume()
            } catch {
                continuation.resume(with: .failure(error))
            }
        }
    }
    
    func writeJSON<T>(_ t: T, to url: URL) async throws where T: Encodable {
        try await withUnsafeThrowingContinuation { continuation in
            do {
                let data = try jsonEncoder.encode(t)
                Self.log("Writing JSON \(String(data: data, encoding: .utf8) ?? "cant parse") to \(url.path(percentEncoded: false))")
                
                try data.write(to: url)
                Self.log("JSON written")
                
                continuation.resume()
            } catch {
                continuation.resume(with: .failure(error))
            }
        }
    }
}

private extension FileService {
    
    var documentDirectory: URL? {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    }
    
    func getURL(_ url: String) -> URL? {
        switch type {
        case .local:
            let url = documentDirectory?.appendingPathComponent(url)
            print("Local URL: \(url?.path(percentEncoded: false) ?? "Failed")")
            return url
        case .iCloud:
            let url = FileManager.default.url(forUbiquityContainerIdentifier: nil)?.appendingPathComponent("Documents/" + url)
            print("iCloud URL: \(url?.path(percentEncoded: false) ?? "Failed")")
            return url
        }
    }
}

private extension FileService {
    
    static let logEvents = false
    
    static func log(_ message: String) {
        guard logEvents else { return }
        print("[File Manager] \(message)")
    }
    
    static func error(_ message: String) {
        guard Self.logEvents else { return }
        print("[File Manager]❗️\(message)")
    }
}
