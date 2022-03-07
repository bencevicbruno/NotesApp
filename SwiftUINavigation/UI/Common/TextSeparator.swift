//
//  TextSeparator.swift
//  SwiftUINavigation
//
//  Created by Bruno Benčević on 04.03.2022..
//

import SwiftUI

struct TextSeparator: View {
    
    let text: String
    let font: Font
    let fontWeight: Font.Weight
    
    var body: some View {
        HStack {
            Rectangle()
                .frame(height: 2)
                .frame(minWidth: 10)
            
            Text(text)
                .font(font)
                .fontWeight(fontWeight)
            
            Rectangle()
                .frame(height: 2)
                .frame(minWidth: 10)
        }
    }
    
    init(_ text: String, font: Font, fontWeight: Font.Weight = .regular) {
        self.text = text
        self.font = font
        self.fontWeight = fontWeight
    }
}

struct TextSeparator_Previews: PreviewProvider {
    static var previews: some View {
        TextSeparator("Preview", font: .system(size: 14))
    }
}
