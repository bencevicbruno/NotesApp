//
//  ChoiceDialogModal.swift
//  NotesApp
//
//  Created by Bruno Bencevic on 08.03.2023..
//

import SwiftUI

struct ChoiceDialogModal: View {
    
    @Binding var binding: ChoiceDialog?
    
    init(_ binding: Binding<ChoiceDialog?>) {
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
                    .padding(.bottom, 16)
                
                VStack(spacing: 4) {
                    ForEach(0..<dialog.choices.count, id: \.self) { index in
                        choiceCell(dialog.choices[index], index)
                    }
                }
            }
            .padding(16)
        }
    }
}

private extension ChoiceDialogModal {
    
    func choiceCell(_ choice: ChoiceDialog.Choice, _ index: Int) -> some View {
        HStack(spacing: 16) {
            Image.custom(choice.image)
                .resizable()
                .renderingMode(.template)
                .scaledToFit()
                .frame(width: 24, height: 24)
                .frame(width: 40, height: 40)
            
            Text(verbatim: choice.title)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .foregroundColor(.blue)
        .frame(height: 44)
        .onTapGesture {
            binding?.action(index)
            binding = nil
        }
    }
}

struct ChoiceDialogModal_Previews: PreviewProvider {
    
    static var previews: some View {
        ChoiceDialogModal(.constant(.sample()))
    }
}
