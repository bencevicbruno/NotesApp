//
//  Note.swift
//  SwiftUINavigation
//
//  Created by Bruno Benčević on 28.02.2022..
//

import Foundation

struct Note: Identifiable, Codable {
    
    private(set) var id = UUID()
    let title: String
    let description: String
    let text: String
    let date: Date
    var isFavorite: Bool
    let author: String
    
    static let test = Note(title: "Test Note",
                           description: "Note to be tested",
                           text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
                           date: Date(timeIntervalSince1970: 0),
                           isFavorite: true,
                           author: "Testing Inc.")
}
