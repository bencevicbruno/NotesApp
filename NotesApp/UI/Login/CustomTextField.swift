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
    @Binding var isTextValid: Bool
    @Binding var isFocused: Bool
    let onCommit: () -> Void
    let validators: [any StringValidator]
    
    init(title: String, text: Binding<String>, isTextValid: Binding<Bool> = .constant(true), isFocused: Binding<Bool>, onCommit: @escaping () -> Void = {}, validators: [any StringValidator] = []) {
        self.title = title
        self._text = text
        self._isTextValid = isTextValid
        self._isFocused = isFocused
        self.onCommit = onCommit
        self.validators = validators
    }
    
    @FocusState private var isFieldFocused
    
    var body: some View {
        VStack(spacing: 0) {
            TextField(title, text: $text, onCommit: onCommit)
                .focused($isFieldFocused)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
                .foregroundColor(.black)
            
            Rectangle()
                .fill(!isTextValid ? .red : isFieldFocused ? .blue : .gray)
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
        .onChange(of: text) { text in
            isTextValid = validators.allSatisfy { $0.isValid(text) }
        }
    }
}

struct CustomTextField_Previews: PreviewProvider {
    
    static var previews: some View {
        CustomTextField(title: "Test", text: .constant("Example"), isFocused: .constant(true), onCommit: {})
    }
}
