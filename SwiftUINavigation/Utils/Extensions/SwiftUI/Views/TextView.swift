//
//  TextView.swift
//  SwiftUINavigation
//
//  Created by Bruno Benčević on 02.03.2022..
//

import Foundation
import SwiftUI

struct TextView: UIViewRepresentable {
    
    @Binding var text: String
    
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.font = .systemFont(ofSize: 14)
        textView.autocapitalizationType = .sentences
        textView.isSelectable = true
        textView.isUserInteractionEnabled = true
        textView.backgroundColor = .clear
        textView.delegate = context.coordinator
        
        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        if text == "" {
            print("trying to reset text!")
        }
        uiView.text = text
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator($text)
    }
     
    class Coordinator: NSObject, UITextViewDelegate {
        var text: Binding<String>
     
        init(_ text: Binding<String>) {
            self.text = text
        }
     
        func textViewDidChange(_ textView: UITextView) {
            self.text.wrappedValue = textView.text
        }
    }
}
