//
//  View+Shadow.swift
//  NotesApp
//
//  Created by Bruno Bencevic on 09.03.2023..
//

import SwiftUI

extension View {
    
    func addShadow(_ color: Color = .black.opacity(0.3), radius: CGFloat = 8) -> some View {
        self.background(
            color
                .blur(radius: radius)
        )
    }
}
