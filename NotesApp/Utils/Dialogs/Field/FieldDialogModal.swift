//
//  FieldDialogModal.swift
//  NotesApp
//
//  Created by Bruno Bencevic on 07.03.2023..
//

import SwiftUI

struct FieldDialogModal: View {
    
    @Binding var binding: FieldDialog?
    
    @State private var text = ""
    @State private var isTextValid = true
    @State private var isFieldFocused = true
    
    init(_ binding: Binding<FieldDialog?>) {
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
                
                CustomTextField(title: dialog.hint, text: $text, isTextValid: $isTextValid, isFocused: $isFieldFocused, onCommit: {
                    guard isTextValid else { return }
                    dialog.action?(text)
                    binding = nil
                })
                .padding(.top, 16)
                .padding(.horizontal, 8)
                
                Text(verbatim: dialog.okTitle)
                    .foregroundColor(.blue)
                    .frame(height: 60)
                    .frame(maxWidth: .infinity)
                    .background(.white)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        guard isTextValid else { return }
                        dialog.action?(text)
                        binding = nil
                    }
            }
            .padding([.top, .horizontal], 16)
        }
    }
}

struct FieldDialogModal_Previews: PreviewProvider {
    
    static var previews: some View {
        FieldDialogModal(.constant(.sample()))
    }
}
