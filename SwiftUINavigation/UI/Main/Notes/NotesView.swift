//
//  NotesView.swift
//  SwiftUINavigation
//
//  Created by Bruno Benčević on 25.02.2022..
//

import SwiftUI

struct NotesView: View {
    
    @ObservedObject var viewModel: NotesViewModel
    
    var body: some View {
        ZStack(alignment: .top) {
            background
            
            VStack(spacing: 0) {
                navigationBar
                
                content
            }
            .edgesIgnoringSafeArea(.top)
        }
    }
}

private extension NotesView {
    
    var background: some View {
        Image("background_notes")
            .resizable()
            .ignoresSafeArea(.all, edges: .top)
    }
    
    var navigationBar: some View {
        VStack(spacing: 0) {
            Rectangle()
                .fill(.white)
                .frame(height: UIScreen.main.topSafeAreaPadding)
            
            ZStack(alignment: .center) {
                RoundedRectangle.rounded(.white, top: 0, bottom: 10)
                
                HStack(spacing: 0) {
                    Rectangle()
                        .fill(.white)
                        .frame(width: 20, height: 20)
                    
                    Spacer(minLength: 10)
                    
                    Text("Notes")
                        .font(.system(size: 24))
                        .fontWeight(.bold)
                    
                    Spacer(minLength: 10)
                    
                    Image(systemName: "plus")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .foregroundColor(.blue)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            viewModel.goToNewNote()
                        }
                }
                .padding(.horizontal, 10)
            }
            .frame(height: 50)
        }
    }
    
    var content: some View {
        ScrollView(.vertical) {
            LazyVStack(spacing: 0) {
                ForEach(viewModel.notes) { note in
                    let index = viewModel.notes.firstIndex(where: { $0.id == note.id })!
                    
                    NoteCell(viewModel.notes[index]) {
                        viewModel.goToDetail(noteIndex: index)
                    } onHeartTapped: {
                        viewModel.toggleFavorite(noteIndex: index)
                    }
                }
            }
        }
        .background(RoundedRectangle
                        .rounded(.ultraThin, top: 0, bottom: 10)
                        .padding(.horizontal, 10))
        .clipped()
    }
}

struct NotesView_Previews: PreviewProvider {
    static var previews: some View {
        NotesView(viewModel: NotesViewModel(notesService: ServiceFactory.notesService))
    }
}
