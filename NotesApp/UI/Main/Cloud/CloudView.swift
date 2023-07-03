//
//  CloudView.swift
//  NotesApp
//
//  Created by Bruno Bencevic on 13.03.2023..
//

import SwiftUI

struct CloudView: View {
    
    @StateObject var viewModel: CloudViewModel
    
    init(navigationPath: Binding<NavigationPath>) {
        self._viewModel = .init(wrappedValue: .init(navigationPath: navigationPath))
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            content
            
            NavigationBar("iCloud")
            //                .leadingAction(imageName: "goforward", viewModel.loadNotes)
        }
        .edgesIgnoringSafeArea(.all)
        .background(background)
    }
}

private extension CloudView {
    
    var background: some View {
        Image("background_icloud")
            .resizable()
            .scaledToFill()
            .blur(radius: 8)
            .frame(width: UIScreen.width, height: UIScreen.height)
    }
    
    var content: some View {
        Text("3 databases - public, private, shared")
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
}

struct CloudView_Previews: PreviewProvider {
    
    static var previews: some View {
        CloudView(navigationPath: .constant(.init()))
    }
}
