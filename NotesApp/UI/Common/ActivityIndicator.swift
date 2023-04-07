//
//  ActivityIndicator.swift
//  NotesApp
//
//  Created by Bruno Bencevic on 15.03.2023..
//

import SwiftUI

struct ActivityIndicator: View {
    
    let isVisible: Bool
    let numberOfCircles = 3
    let animationDuration = 0.4
    
    @State private var didAppear = false
    
    var body: some View {
        HStack(spacing: 16) {
            ForEach(1...numberOfCircles, id: \.self) { index in
                Circle()
                    .fill(.thinMaterial)
                    .frame(width: didAppear ? 24 : 32,
                           height: didAppear ? 24 : 32)
                    .frame(width: 32, height: 32)
                .shadow(color: .white.opacity(0.5), radius: 16)
                .animation(.easeIn(duration: animationDuration).repeatForever(autoreverses: true).delay(animationDuration / Double(numberOfCircles) * Double(index)), value: didAppear)
            }
        }
        .onAppear {
            didAppear = true
        }
        .opacity(isVisible ? 1 : 0)
        .allowsHitTesting(isVisible)
        .animation(.linear, value: isVisible)
    }
}

struct ActivityIndicator_Previews: PreviewProvider {
    
    static var previews: some View {
        ActivityIndicator(isVisible: true)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.black)
    }
}
