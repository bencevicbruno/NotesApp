//
//  ShareNoteView.swift
//  SwiftUINavigation
//
//  Created by Bruno Benčević on 28.02.2022..
//

import SwiftUI

struct ShareNoteView: View {
    
    @ObservedObject var viewModel: ShareNoteViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            navigationBar
            
            content
        }
        .removeNavigationBar()
    }
}

private extension ShareNoteView {
    
    var navigationBar: some View {
        HStack(spacing: 0) {
            Rectangle()
                .fill(.white)
                .frame(width: 30, height: 30)
            
            Spacer(minLength: 10)
            
            Text("Share")
                .font(.system(size: 24))
                .fontWeight(.bold)
            
            Spacer(minLength: 10)
            
            Text("X")
                .font(.system(size: 25, weight: .medium))
                .frame(width: 30, height: 30)
                .foregroundColor(.blue)
                .contentShape(Rectangle())
                .onTapGesture {
                    viewModel.xTapped()
                }
        }
        .padding(.horizontal, 10)
        .frame(height: 50)
        .background(RoundedRectangle.rounded(.white, top: 0, bottom: 10))
    }
    
    var content: some View {
        VStack(spacing: 20) {
            Text("Click the button below to share the note.")
                .fontWeight(.medium)
                .multilineTextAlignment(.center)
                .frame(maxWidth: 200)
            
            shareButton
        }
        .maxFrame()
        .background(LinearGradient(colors: [.init(uiColor: .lightGray), .white, .white], startPoint: .bottom, endPoint: .top))
    }
    
    var shareButton: some View {
        Button {
            viewModel.shareTapped()
        } label: {
            Text("Share")
                .fontWeight(.bold)
                .padding(.vertical, 10)
                .padding(.horizontal, 50)
                .background(RoundedRectangle(cornerRadius: 5)
                                .fill(Color.body)
                                .shadow(color: .gray, radius: 5, x: 0, y: 5))
        }
    }
}

struct ShareNoteView_Previews: PreviewProvider {
    static var previews: some View {
        ShareNoteView(viewModel: ShareNoteViewModel(.test))
    }
}
