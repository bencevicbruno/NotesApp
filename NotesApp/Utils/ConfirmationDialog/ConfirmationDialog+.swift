//
//  ConfirmationDialog+.swift
//  SwiftUINavigation
//
//  Created by Bruno Benčević on 03.03.2022..
//

import Foundation
import SwiftUI

extension View {
    
    func confirmationDialog(_ binding: Binding<ConfirmationDialog?>) -> some View {
        self.overlay(alignment: .bottom) {
            ConfirmationDialogModal(binding)
        }
    }
}

extension View {
    
    func alertDialog(_ binding: Binding<AlertDialog?>) -> some View {
        self.overlay(alignment: .bottom) {
//            AlertDialogModal(binding)
        }
    }
}
