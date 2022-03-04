//
//  ConfirmationDialog+.swift
//  SwiftUINavigation
//
//  Created by Bruno Benčević on 03.03.2022..
//

import Foundation
import SwiftUI

extension View {
    
    func confirmationDialog(_ confirmationDialog: Binding<ConfirmationDialog?>) -> some View{
        let isVisible = Binding(
            get: { confirmationDialog.wrappedValue != nil },
            set: { value in
                if !value {
                    confirmationDialog.wrappedValue = nil
                }
            }
        )
        
        return ZStack {
            self
            
            if let dialog = confirmationDialog.wrappedValue {
                ConfirmationDialogView(isVisible, dialog: dialog)
            }
        }
    }
}
