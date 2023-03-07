//
//  ConfirmationDialogModal.swift
//  SwiftUINavigation
//
//  Created by Bruno Benčević on 03.03.2022..
//

import SwiftUI

struct DialogModalBase<D, Content>: View where D: Dialog, Content: View {
    
    @Binding var dialog: D?
    private let content: (D) -> Content
    
    var body: some View {
        Group {
            if let dialog {
                content(dialog)
                    .frame(maxWidth: .infinity)
                    .background(.white)
                    .cornerRadius(16)
                    .shadow(radius: 16)
                    .padding(.horizontal, 20)
                    .padding(.bottom, max(UIScreen.unsafeBottomPadding, 20))
                    .transition(.move(edge: .bottom)
                        .animation(.linear(duration: 0.25)))
                    .onTapGesture {}
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .background(.ultraThinMaterial.opacity(self.dialog == nil ? 0 : 1))
        .animation(.linear(duration: 0.25), value: dialog)
        .onTapGesture {
            dialog?.dismissAction?()
        }
    }
}

struct ConfirmationDialogModal: View {
    
    @Binding var dialog: ConfirmationDialog?
    
    var body: some View {
        Group {
            if let dialog {
                VStack(spacing: 0) {
                    VStackLayout(spacing: 16) {
                        Text(verbatim: dialog.title)
                            .font(.headline)
                            .fontWeight(.bold)
                        
                        if let message = dialog.message {
                            Text(verbatim: message)
                                .font(.body)
                        }
                    }
                    
                    Color.gray
                        .frame(height: 1)
                        .padding(.top, 16)
                    
                    HStack(spacing: 0) {
                        Text(verbatim: dialog.cancelTitle)
                            .foregroundColor(.blue)
                            .frame(height: 60)
                            .frame(maxWidth: .infinity)
                            .background(.white)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                cancelTapped()
                            }
                        
                        Text(verbatim: dialog.confirmationTitle)
                            .fontWeight(.medium)
                            .foregroundColor(.blue)
                            .frame(height: 60)
                            .frame(maxWidth: .infinity)
                            .background(.white)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                confirmTapped()
                            }
                    }
                }
                .padding([.top, .horizontal], 16)
                .frame(maxWidth: .infinity)
                .background(.white)
                .cornerRadius(16)
                .shadow(radius: 16)
                .padding(.horizontal, 20)
                .padding(.bottom, max(UIScreen.unsafeBottomPadding, 20))
                .transition(.move(edge: .bottom)
                    .animation(.linear(duration: 0.25)))
                .onTapGesture {}
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .background(.ultraThinMaterial.opacity(self.dialog == nil ? 0 : 1))
        .animation(.linear(duration: 0.25), value: dialog)
        .onTapGesture {
            cancelTapped()
        }
    }
    
    init(_ binding: Binding<ConfirmationDialog?>) {
        self._dialog = binding
    }
}

private extension ConfirmationDialogModal {
    
    func cancelTapped() {
        dialog?.cancelAction?()
        
        withAnimation {
            dialog = nil
        }
    }
    
    func confirmTapped() {
        dialog?.confirmAction?()
        
        withAnimation {
            dialog = nil
        }
    }
}

struct ConfirmationDialogModal_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmationDialogModal(.constant(.init(title: "Test", message: "This is a test dialog.", confirmationTitle: "OK")))
        
        ConfirmationDialogModal(.constant(.init(title: "Test", message: nil, confirmationTitle: "OK")))
    }
}
