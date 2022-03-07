//
//  NoteCell.swift
//  SwiftUINavigation
//
//  Created by Bruno Benčević on 28.02.2022..
//

import SwiftUI

struct NoteCell: View {
    
    private var note: Note
    private var onTapped: EmptyCallback?
    private var onHeartTapped: EmptyCallback?
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack {
                    Text(note.title)
                        .fontWeight(.bold)
                    
                    Spacer(minLength: 10)
                }
                
                HStack {
                    Text(note.description)
                    
                    Spacer(minLength: 10)
                }
            }
            
            Rectangle()
                .fill(.black)
                .frame(width: 2)
                .padding(.vertical, 10)
                .padding(.trailing, 5)
            
            Image(systemName: note.isFavorite ? "heart.fill" : "heart")
                .contentShape(Rectangle())
                .onTapGesture {
                    onHeartTapped?()
                }
        }
        .frame(height: 50)
        .frame(maxWidth: .infinity)
        .onTapGesture {
            onTapped?()
        }
        .padding(.horizontal, 20)
    }
    
    init(_ note: Note, onTapped: EmptyCallback? = nil, onHeartTapped: EmptyCallback? = nil) {
        self.note = note
        self.onTapped = onTapped
        self.onHeartTapped = onHeartTapped
    }
}

struct NoteCell_Previews: PreviewProvider {
    static var previews: some View {
        NoteCell(.test)
            .background(Color.red)
    }
}
