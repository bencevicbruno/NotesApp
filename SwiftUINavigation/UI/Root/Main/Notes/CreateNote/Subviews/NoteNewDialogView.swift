//
//  NoteNewDialogView.swift
//  SwiftUINavigation
//
//  Created by Bruno Benčević on 02.03.2022..
//

import SwiftUI

struct NoteNewDialogView: View {
    
    @Binding var isPresented: Bool
    @Binding var title: String
    @Binding var author: String
    @Binding var isFavorite: Bool
    var onSaveTapped: EmptyCallback?
    
    var body: some View {
        VStack {
            Text("Enter note details")
                .font(.system(size: 20))
                .fontWeight(.bold)
            
            HStack {
                Text("Title: ")
                
                TextField("Title", text: $title)
            }
            
            HStack {
                Text("Author: ")
                
                TextField("Author", text: $author)
            }
            
            Toggle("Is Favorite:", isOn: $isFavorite)
            
            HStack(spacing: 50) {
                Button("Cancel") {
                    withAnimation {
                        isPresented = false
                    }
                }
                
                Button("Save") {
                    onSaveTapped?()
                }
            }
            .padding(.vertical, 10)
        }
        .frame(width: 250)
        .padding(10)
        .background(RoundedRectangle(cornerRadius: 10)
                        .fill(Color.white))
    }
}

struct NoteNewDialogView_Previews: PreviewProvider {
    static var previews: some View {
        NoteNewDialogView(isPresented: .constant(true), title: .constant("Test Note"), author: .constant("Testing Inc."), isFavorite: .constant(false))
    }
}
