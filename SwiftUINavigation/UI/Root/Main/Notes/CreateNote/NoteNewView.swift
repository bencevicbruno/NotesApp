//
//  NoteNewView.swift
//  SwiftUINavigation
//
//  Created by Bruno Benčević on 01.03.2022..
//

import SwiftUI

struct NoteNewView: View {
    
    @ObservedObject var viewModel: NoteNewViewModel
    
    var body: some View {
        ZStack(alignment: .top) {
            background
            
            VStack(spacing: 0) {
                navigationBar
                
                content
            }
            .edgesIgnoringSafeArea(.top)
        }
        .fullScreenCover(isPresented: $viewModel.isShowingDialog) {
            ZStack {
                Rectangle()
                    .fill(.thinMaterial)
                    .opacity(viewModel.isShowingDialog ? 1 : 0)
                
                NoteNewDialogView(isPresented: $viewModel.isShowingDialog,
                                  title: $viewModel.title,
                                  author: $viewModel.author,
                                  isFavorite: $viewModel.isFavorite,
                                  onSaveTapped: { viewModel.saveNote() })
                    .offset(y: viewModel.isShowingDialog ? 0 : UIScreen.main.bounds.height)
            }
            
        }
    }
    
    var background: some View {
        Image("background_notebook")
            .resizable()
            .ignoresSafeArea(.all, edges: [.top, .bottom])
    }
    
    var navigationBar: some View {
        VStack(spacing: 0) {
            Rectangle()
                .fill(.white)
                .frame(height: UIScreen.main.topSafeAreaPadding)
            
            ZStack(alignment: .center) {
                RoundedRectangle.rounded(.white, top: 0, bottom: 10)
                
                HStack(spacing: 0) {
                    Text("Cancel")
                        .font(.system(size: 16))
                        .fontWeight(.medium)
                        .foregroundColor(.blue)
                        .frame(width: 60)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            viewModel.dismiss()
                        }
                    
                    Spacer(minLength: 10)
                    
                    Text("New Note")
                        .font(.system(size: 24))
                        .fontWeight(.bold)
                    
                    Spacer(minLength: 10)
                    
                    Text("Save")
                        .font(.system(size: 16))
                        .fontWeight(.medium)
                        .foregroundColor(.blue)
                        .frame(width: 60)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            viewModel.presentDialog()
                        }
                }
                .padding(.horizontal, 5)
            }
            .frame(height: 50)
        }
    }
    
    var content: some View {
        VStack {
            Text("Enter your text below")
            
            TextView(text: $viewModel.text)
                .background(Color.gray.opacity(0.5))
                .aspectRatio(0.75, contentMode: .fit)
                .id(0)
            
            Text("Description")
            
            TextView(text: $viewModel.description)
                .background(Color.gray.opacity(0.5))
                .frame(width: 150, height: 40)
                .id(1)
            
        }
        .padding(.horizontal, 40)
        .padding(.vertical, 5)
    }
}

struct NoteNewView_Previews: PreviewProvider {
    static var previews: some View {
        NoteNewView(viewModel: NoteNewViewModel(notesService: ServiceFactory.notesService))
    }
}
