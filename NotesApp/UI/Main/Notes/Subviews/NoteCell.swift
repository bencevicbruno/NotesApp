//
//  NoteCell.swift
//  SwiftUINavigation
//
//  Created by Bruno Benčević on 28.02.2022..
//

import SwiftUI

struct NoteCell: View {
    
    private var note: Note
    
    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 0) {
                Text(note.title)
                    .font(.body)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text(note.description)
                    .font(.callout)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 4)
                
                Text(note.date.formatted())
                    .font(.caption2)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.vertical, 8)
            
            Image(systemName: note.isFavorite ? "heart.fill" : "heart")
                .resizable()
                .scaledToFit()
                .frame(width: 24, height: 24)
                .frame(width: 40, height: 40)
                .frame(maxHeight: .infinity)
                .contentShape(Rectangle())
        }
        .frame(maxWidth: .infinity, minHeight: 50)
        .fixedSize(horizontal: false, vertical: true)
        .padding(.horizontal, 16)
        .background(.thinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
    
    init(_ note: Note) {
        self.note = note
    }
}

struct NoteCell_Previews: PreviewProvider {
    static var previews: some View {
        NoteCell(.sample)
            .padding()
    }
}
