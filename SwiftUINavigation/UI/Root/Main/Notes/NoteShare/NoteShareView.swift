//
//  NoteShareView.swift
//  SwiftUINavigation
//
//  Created by Bruno Benčević on 28.02.2022..
//

import SwiftUI

struct NoteShareView: View {
    
    @ObservedObject var viewModel: NoteShareViewModel
    
    var body: some View {
        NavigationView {
            Form {
                Text("Click the button below to share the note")
                
                Button("Share") {
                    viewModel.share()
                }
                .buttonStyle(.borderless)
                
                Text("Or just ignore this screen and dismiss it...")
                
                Button("Dismiss") {
                    viewModel.dismiss()
                }
            }
            .navigationTitle("Share \(viewModel.note.title)")
        }
    }
}

struct NoteShareView_Previews: PreviewProvider {
    static var previews: some View {
        NoteShareView(viewModel: NoteShareViewModel(.test))
    }
}
