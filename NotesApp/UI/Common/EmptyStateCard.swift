//
//  EmptyStateCard.swift
//  NotesApp
//
//  Created by Bruno Bencevic on 13.03.2023..
//

import SwiftUI

struct EmptyStateCard: View {
    let title: String
    let message: String?
    let systemImageName: String
    
    var body: some View {
        VStack(spacing: 0) {
            Image(systemName: systemImageName)
                .resizable()
                .scaledToFit()
                .padding(.bottom, 32)
                .frame(width: UIScreen.width / 3)
            
            Text(verbatim: title)
                .font(.title)
                .fontWeight(.bold)
                .padding(.bottom, 16)
            
            if let message {
                Text(verbatim: message)
                    .font(.body)
                    .fontWeight(.medium)
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 32)
        .frame(width: UIScreen.width - 2 * 20)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

struct EmptyStateCard_Previews: PreviewProvider {
    
    static var previews: some View {
        EmptyStateCard(title: "No notes", message: "Tap on the + button to make one.", systemImageName: "doc.text.magnifyingglass")
    }
}
