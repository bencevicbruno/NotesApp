//
//  LoadingOverlay.swift
//  SwiftUINavigation
//
//  Created by Bruno Benčević on 04.03.2022..
//

import SwiftUI

struct LoadingOverlay: View {
    
    @State private var isAnimating = false
    
    var body: some View {
        HStack {
            circle
                .scaleEffect(isAnimating ? 1.0 : 0.5)
                .animation(animationEffect(), value: isAnimating)
            circle
                .scaleEffect(isAnimating ? 1.0 : 0.5)
                .animation(animationEffect(delay: 0.33), value: isAnimating)
            circle
                .scaleEffect(isAnimating ? 1.0 : 0.5)
                .animation(animationEffect(delay: 0.66), value: isAnimating)
        }
        .onAppear {
            withAnimation(.linear(duration: 0.5)) {
                self.isAnimating = true
            }
        }
        .onDisappear {
            withAnimation(.linear(duration: 0.5)) {
                self.isAnimating = false
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Rectangle()
                        .fill(.ultraThinMaterial)
                        .opacity(isAnimating ? 1 : 0))
    }
    
    private var circle: some View {
        Circle()
            .fill(Color.blue)
            .frame(width: 20, height: 20)
    }
    
    private func animationEffect(delay: CGFloat = 0) -> Animation {
        return Animation.easeInOut(duration: 0.5).repeatForever().delay(delay)
    }
}

extension View {
    
    func loadingOverlay(isLoading: Bool) -> some View {
        ZStack {
            self
            
            if isLoading {
                LoadingOverlay()
            }
        }
    }
}

struct LoadingOverlay_Previews: PreviewProvider {
    static var previews: some View {
        LoadingOverlay()
    }
}
