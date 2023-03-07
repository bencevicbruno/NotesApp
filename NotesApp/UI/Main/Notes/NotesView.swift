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
            content
            
            NavigationBar("Notes")
        }
        .edgesIgnoringSafeArea(.all)
        .background(background)
    }
}

private extension NotesView {
    
    var background: some View {
        Image("background_notes")
            .resizable()
            .scaledToFill()
            .blur(radius: 8)
            .frame(width: UIScreen.width, height: UIScreen.height)
    }
    
    var content: some View {
        ScrollView(.vertical) {
            LazyVStack(spacing: 0) {
                ForEach(viewModel.notes) {
                    NoteCell($0)
                        .padding(.vertical, 8)
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, NavigationBar.totalHeight)
            .padding(.bottom, MainTabBar.totalHeight)
        }
    }
}

struct NotesView_Previews: PreviewProvider {
    static var previews: some View {
        NotesView(viewModel: NotesViewModel(notesService: ServiceFactory.notesService))
    }
}
