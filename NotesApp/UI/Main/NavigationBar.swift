//
//  NavigationBar.swift
//  SwiftUINavigation
//
//  Created by Bruno Bencevic on 07.03.2023..
//

import SwiftUI

struct NavigationBar: View {
    
    private let title: String
    private var leadingButtonImageName: String?
    private var trailingButtonImageName: String?
    private var leadingButtonCallback: EmptyCallback?
    private var trailingButtonCallback: EmptyCallback?
    
    init(_ title: String) {
        self.title = title
        self.leadingButtonImageName = nil
        self.leadingButtonCallback = nil
        self.trailingButtonImageName = nil
        self.trailingButtonCallback = nil
    }
    
    func leadingAction(imageName image: String, _ action: @escaping EmptyCallback) -> NavigationBar {
        var newNavigationBar = self
        
        newNavigationBar.leadingButtonImageName = image
        newNavigationBar.leadingButtonCallback = action
        
        return newNavigationBar
    }
    
    func trailingAction(imageName image: String, _ action: @escaping EmptyCallback) -> NavigationBar {
        var newNavigationBar = self
        
        newNavigationBar.trailingButtonImageName = image
        newNavigationBar.trailingButtonCallback = action
        
        return newNavigationBar
    }
    
    var body: some View {
        HStack(spacing: 0) {
            if let leadingButtonImageName {
                Image(systemName: leadingButtonImageName)
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.blue)
                    .frame(width: Self.imageSize, height: Self.imageSize)
                    .frame(width: 40, height: 40)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        leadingButtonCallback?()
                    }
            } else {
                Color.clear
                    .frame(width: 40, height: 40)
            }
            
            Spacer()
            
            Text(title)
                .font(.headline)
                .fontWeight(.semibold)
            
            Spacer()
            
            if let trailingButtonImageName {
                Image(systemName: trailingButtonImageName)
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.blue)
                    .frame(width: Self.imageSize, height: Self.imageSize)
                    .frame(width: Self.imageTapSize, height: Self.imageTapSize)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        trailingButtonCallback?()
                    }
            } else {
                Color.clear
                    .frame(width: Self.imageTapSize, height: Self.imageTapSize)
            }
        }
        .padding(.horizontal, 20)
        .padding(.bottom, Self.bottomPadding)
        .padding(.top, Self.topPadding)
        .background(.white)
        .mask {
            navigationBarMask
        }
    }
    
    static let imageSize: CGFloat = 24
    static let imageTapSize: CGFloat = 40
    static let topPadding: CGFloat = max(8, UIScreen.unsafeTopPadding)
    static let bottomPadding: CGFloat = 8
    
    static let totalHeight: CGFloat = Self.topPadding + Self.imageTapSize + Self.bottomPadding
}

private extension NavigationBar {
    
    var navigationBarMask: some View {
        ZStack {
            Rectangle()
                .padding(.bottom, max(8, UIScreen.unsafeTopPadding / 2))
                
            RoundedRectangle(cornerRadius: max(8, UIScreen.unsafeTopPadding / 2))
        }
    }
}

struct NavigationBar_Previews: PreviewProvider {
    
    static var previews: some View {
        NavigationBar("Sample Title")
            .leadingAction(imageName: "plus", {})
            .trailingAction(imageName: "minus", {})
            .shadow(radius: 16)
    }
}
