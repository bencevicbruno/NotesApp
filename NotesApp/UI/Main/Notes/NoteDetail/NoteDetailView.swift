//
//  NoteDetailView.swift
//  SwiftUINavigation
//
//  Created by Bruno Benčević on 28.02.2022..
//

import SwiftUI

struct NoteDetailView: View {
    
    @ObservedObject var viewModel: NoteDetailViewModel
    
    var body: some View {
        ZStack(alignment: .top) {
            content
                .padding(.top, NavigationBar.totalHeight)
                .background(
                    Image("background_notebook")
                        .resizable()
                        .scaledToFill()
                        .frame(width: UIScreen.width, height: UIScreen.height)
                        .opacity(0.5)
                )
            
            NavigationBar("Note")
                .leadingAction(systemImageName: "chevron.left", viewModel.dismiss())
                .trailingAction(systemImageName: "square.and.arrow.up", viewModel.showOptions())
        }
        .removeNavigationBar()
        .edgesIgnoringSafeArea(.all)
        .alertDialog($viewModel.alertDialog)
        .choiceDialog($viewModel.choiceDialog)
        .confirmationDialog($viewModel.confirmationDialog)
        .overlay {
            ActivityIndicator(isVisible: viewModel.isActivityRunning)
        }
    }
    
    var noteDate: String {
        viewModel.note.date.formatted(.dateTime).components(separatedBy: " ").first ?? "unknown"
    }
}

private extension NoteDetailView {
    
    var content: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading, spacing: 12) {
                Text(verbatim: viewModel.note.title)
                    .font(.title)
                    .fontWeight(.bold)
                
                Text(verbatim: viewModel.note.text)
                    .font(.body)
                    .fontWeight(.medium)
                    .lineSpacing(12.5)
                
                VStack(alignment: .trailing, spacing: 4) {
                    Text("- *\(viewModel.note.author)*")
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    
                    Text(verbatim: viewModel.note.date.formatted())
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
            }
            .padding(20)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        }
    }
}

struct NoteDetailView_Previews: PreviewProvider {
    
    static var previews: some View {
        NoteDetailView(viewModel: NoteDetailViewModel(.sample(), navigationPath: .constant(.init())))
    }
}
