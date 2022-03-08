//
//  DialogView.swift
//  SwiftUINavigation
//
//  Created by Bruno Benčević on 05.03.2022..
//

import SwiftUI

struct DialogView: View {
    
    @Binding var isVisible: Bool
    let dialog: Dialog
    
    @State private var didAnimate = false
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.ultraThinMaterial)
                .opacity(didAnimate ? 1 : 0)
                .allowsHitTesting(didAnimate)
            
            VStack {
                Group {
                    Text(dialog.title)
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                        .padding(.vertical, 10)
                    
                    if let message = dialog.message {
                        Text(message)
                    }
                }
                .padding(10)
                
                Text(dialog.okTitle)
                    .foregroundColor(.blue)
                    .frame(height: 50)
                    .frame(maxWidth: 250)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        onOKTapped()
                    }
                    .background(RoundedRectangle.rounded(.ultraThin, topLeft: 0, topRight: 0, bottomLeft: 5, bottomRight: 5))
            }
            .multilineTextAlignment(.center)
            .background(RoundedRectangle(cornerRadius: 10)
                            .fill(.white))
            .frame(maxWidth: 250)
            .offset(y: didAnimate ? 0 : UIScreen.main.bounds.height)
            .opacity(didAnimate ? 1 : 0)
        }
        .onAppear {
            withAnimation {
                didAnimate = true
            }
        }
        .onDisappear {
            withAnimation {
                didAnimate = false
            }
        }
    }
    
    init(_ isVisible: Binding<Bool>, dialog: Dialog) {
        self._isVisible = isVisible
        self.dialog = dialog
    }
}

extension DialogView {
    
    func onOKTapped() {
        dialog.okAction?()
        
        withAnimation(.linear(duration: 0.5)) {
            didAnimate = false
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            isVisible = false
        }
    }
}

struct DialogView_Previews: PreviewProvider {
    static var previews: some View {
        DialogView(.constant(true), dialog: Dialog(title: "Test Dialog", message: "Test message goes here.", okTitle: "OK", okAction: nil))
    }
}
