//
//  ConfirmationDialogView.swift
//  SwiftUINavigation
//
//  Created by Bruno Benčević on 03.03.2022..
//

import SwiftUI

struct ConfirmationDialogView: View {
    
    @Binding var isVisible: Bool
    let dialog: ConfirmationDialog
    
    @State private var didAnimate = false
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.ultraThinMaterial)
                .opacity(didAnimate ? 0.5 : 0)
                .allowsHitTesting(didAnimate)
                .onTapGesture {
                    onCancelTapped()
                }
            
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
                
                HStack(spacing: 1) {
                    Text(dialog.cancelTitle)
                        .foregroundColor(.blue)
                        .frame(height: 50)
                        .frame(maxWidth: 135)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            onCancelTapped()
                        }
                        .background(RoundedRectangle.rounded(.ultraThin, topLeft: 0, topRight: 0, bottomLeft: 5, bottomRight: 0))
                    
                    Text(dialog.confirmationTitle)
                        .foregroundColor(.blue)
                        .frame(height: 50)
                        .frame(maxWidth: 135)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            onConfirmTapped()
                        }
                        .background(RoundedRectangle.rounded(.ultraThin, topLeft: 0, topRight: 0, bottomLeft: 0, bottomRight: 5))
                }
            }
            .multilineTextAlignment(.center)
            .background(RoundedRectangle(cornerRadius: 10)
                            .fill(.thinMaterial))
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
    
    init(_ isVisible: Binding<Bool>, dialog: ConfirmationDialog) {
        self._isVisible = isVisible
        self.dialog = dialog
    }
}

private extension ConfirmationDialogView {
    
    func onCancelTapped() {
        dialog.cancelAction?()
        disappear()
    }
    
    func onConfirmTapped() {
        dialog.confirmAction?()
        disappear()
    }
    
    func disappear() {
        
        withAnimation(.linear(duration: 0.5)) {
            didAnimate = false
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            isVisible = false
        }
    }
}

struct ConfirmationDialogView_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmationDialogView(.constant(true), dialog: .init(title: "Test", message: "This is a test dialog.", confirmationTitle: "OK"))
        
        ConfirmationDialogView(.constant(true), dialog: .init(title: "Test", message: nil, confirmationTitle: "OK"))
    }
}
