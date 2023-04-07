//
//  Note.swift
//  SwiftUINavigation
//
//  Created by Bruno Benčević on 28.02.2022..
//

import Foundation

struct Note: Identifiable, Codable, Equatable, Hashable {
    let id: UUID
    let title: String
    let text: String
    let date: Date
    let author: String
    
    static func sample(_ id: UUID = UUID()) -> Note {
        Note(id: .init(),
             title: "Test Note",
             text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
             date: Date(timeIntervalSince1970: 0),
             author: "Testing Inc.")
    }
}

extension Array where Element == Note {
    
    static var samples: [Note] {
        Array((0..<10).map { _ in .sample() })
    }
}
