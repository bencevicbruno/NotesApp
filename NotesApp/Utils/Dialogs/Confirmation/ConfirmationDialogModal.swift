//
//  ConfirmationDialogModal.swift
//  NotesApp
//
//  Created by Bruno Bencevic on 07.03.2023..
//

import SwiftUI

struct ConfirmationDialogModal: View {
    
    @Binding var binding: ConfirmationDialog?
    
    init(_ binding: Binding<ConfirmationDialog?>) {
        self._binding = binding
    }
    
    var body: some View {
        DialogBaseModal($binding) { dialog in
            VStack(spacing: 0) {
                VStack(spacing: 16) {
                    Text(verbatim: dialog.title)
                        .font(.headline)
                        .fontWeight(.bold)
                    
                    if let message = dialog.message {
                        Text(verbatim: message)
                            .font(.body)
                    }
                }
                .multilineTextAlignment(.center)
                
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
                            dialog.cancelAction?()
                            binding = nil
                        }
                    
                    Text(verbatim: dialog.confirmationTitle)
                        .fontWeight(.medium)
                        .foregroundColor(.blue)
                        .frame(height: 60)
                        .frame(maxWidth: .infinity)
                        .background(.white)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            dialog.confirmAction?()
                            binding = nil
                        }
                }
            }
            .padding([.top, .horizontal], 16)
        }
    }
}

struct ConfirmationDialogModal_Previews: PreviewProvider {
    
    static var previews: some View {
        ConfirmationDialogModal(.constant(.sample()))
    }
}
