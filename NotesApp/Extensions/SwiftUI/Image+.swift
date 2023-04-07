//
//  Image+.swift
//  NotesApp
//
//  Created by Bruno Bencevic on 05.04.2023..
//

import SwiftUI

enum ImageType {
    case system(String)
    case custom(String)
}

extension Image {
    
    static func custom(_ type: ImageType) -> Image {
        switch type {
        case let .system(systemImageName):
            return Image(systemName: systemImageName)
        case let.custom(imageName):
            return Image(imageName)
        }
    }
}
