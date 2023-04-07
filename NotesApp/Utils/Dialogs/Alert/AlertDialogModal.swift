//
//  AlertDialogModal.swift
//  NotesApp
//
//  Created by Bruno Bencevic on 07.03.2023..
//

import SwiftUI

struct AlertDialogModal: View {
    
    @Binding var binding: AlertDialog?
    
    init(_ binding: Binding<AlertDialog?>) {
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
                
                Text(verbatim: dialog.okTitle)
                    .foregroundColor(.blue)
                    .frame(height: 60)
                    .frame(maxWidth: .infinity)
                    .background(.white)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        dialog.action?()
                        binding = nil
                    }
            }
            .padding([.top, .horizontal], 16)
        }
    }
}

struct AlertDialogModal_Previews: PreviewProvider {
    
    static var previews: some View {
        AlertDialogModal(.constant(.sample()))
    }
}
