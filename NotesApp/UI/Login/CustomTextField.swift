//
//  CustomTextField.swift
//  SwiftUINavigation
//
//  Created by Bruno Bencevic on 06.03.2023..
//

import SwiftUI

struct CustomTextField: View {
    
    let title: String
    @Binding var text: String
    @Binding var isFocused: Bool
    let onCommit: () -> Void
    
    @FocusState private var isFieldFocused
    
    var body: some View {
        VStack(spacing: 0) {
            TextField(title, text: $text, onCommit: onCommit)
                .focused($isFieldFocused)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
                .foregroundColor(.black)
            
            Rectangle()
                .fill(isFieldFocused ? .blue : .gray)
                .frame(height: isFieldFocused ? 4 : 2)
                .frame(height: 4, alignment: .top)
            
        }
        .background(.white)
        .animation(.linear, value: isFieldFocused)
        .onChange(of: isFieldFocused) { isFieldFocused in
            withAnimation {
                isFocused = isFieldFocused
            }
        }
        .onChange(of: isFocused) { isFocused in
            withAnimation {
                isFieldFocused = isFocused
            }
        }
    }
}

struct CustomTextField_Previews: PreviewProvider {
    
    static var previews: some View {
        CustomTextField(title: "Test", text: .constant("Example"), isFocused: .constant(true), onCommit: {})
    }
}
