//
//  NoteCell.swift
//  SwiftUINavigation
//
//  Created by Bruno Benčević on 28.02.2022..
//

import SwiftUI

struct NoteCell: View {
    
    private var note: Note
    private var isFromCloud: Bool
    
    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 0) {
                HStack(spacing: 8) {
                    Text(note.title)
                        .font(.body)
                        .fontWeight(.bold)
                        
                    if isFromCloud {
                        Image(systemName: "icloud")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 16, height: 16)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Text(note.author)
                    .font(.callout)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 4)
                
                Text(note.date.formatted())
                    .font(.caption2)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.vertical, 8)
            
            Spacer()
        }
        .frame(maxWidth: .infinity, minHeight: 50)
        .fixedSize(horizontal: false, vertical: true)
        .padding(.horizontal, 16)
        .background(.thinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
    
    init(_ note: Note, isFromCloud: Bool = false) {
        self.note = note
        self.isFromCloud = isFromCloud
    }
}

struct NoteCell_Previews: PreviewProvider {
    static var previews: some View {
        NoteCell(.sample())
            .padding()
    }
}
