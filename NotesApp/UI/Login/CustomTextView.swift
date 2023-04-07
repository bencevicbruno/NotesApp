//
//  CustomTextView.swift
//  NotesApp
//
//  Created by Bruno Bencevic on 08.03.2023..
//

import SwiftUI

struct CustomTextView: View {
    
    let title: String
    @Binding var text: String
    @Binding var isFocused: Bool
    let onCommit: () -> Void
    
    @FocusState private var isFieldFocused
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            VStack(spacing: 0) {
                TextEditor(text: $text)
                    .focused($isFieldFocused)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                    .foregroundColor(.black)
                    .frame(minHeight: 40)
                
                Rectangle()
                    .fill(isFieldFocused ? .blue : .gray)
                    .frame(height: isFieldFocused ? 4 : 2)
                    .frame(height: 4, alignment: .top)
            }
            
            if text == "" && !isFieldFocused {
                Text(verbatim: title)
                    .foregroundColor(.gray)
                    .padding([.vertical, .leading], 5)
                    .allowsHitTesting(text == "")
                    .frame(minHeight: 40)
                    .padding(.bottom, 4)
                    .onTapGesture {
                        isFieldFocused = true
                    }
                    .transition(.identity)
            }
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

struct CustomTextView_Previews: PreviewProvider {
    
    static var previews: some View {
        CustomTextView(title: "Test", text: .constant("Example"), isFocused: .constant(true), onCommit: {})
            .frame(maxWidth: UIScreen.width)
    }
}
