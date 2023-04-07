//
//  View+Dialog.swift
//  NotesApp
//
//  Created by Bruno Bencevic on 07.03.2023..
//

import SwiftUI

extension View {
    
    func alertDialog(_ binding: Binding<AlertDialog?>) -> some View {
        self.overlay(alignment: .bottom) {
            AlertDialogModal(binding)
        }
    }
    
    func choiceDialog(_ binding: Binding<ChoiceDialog?>) -> some View {
        self.overlay(alignment: .bottom) {
            ChoiceDialogModal(binding)
        }
    }
    
    func confirmationDialog(_ binding: Binding<ConfirmationDialog?>) -> some View {
        self.overlay(alignment: .bottom) {
            ConfirmationDialogModal(binding)
        }
    }
    
    func multipleChoiceDialog(_ binding: Binding<MultipleChoiceDialog?>) -> some View {
        self.overlay(alignment: .bottom) {
            MultipleChoiceModal(binding)
        }
    }
}
