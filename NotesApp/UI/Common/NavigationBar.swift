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
    private var leadingButtonSystemImageName: String?
    private var leadingButtonCallback: EmptyCallback!
    private var secondLeadingButtonImageName: String?
    private var secondLeadingButtonSystemImageName: String?
    private var secondLeadingButtonCallback: EmptyCallback!
    private var trailingButtonImageName: String?
    private var trailingButtonSystemImageName: String?
    private var trailingButtonCallback: EmptyCallback!
    private var secondTrailingButtonImageName: String?
    private var secondTrailingButtonSystemImageName: String?
    private var secondTrailingButtonCallback: EmptyCallback!
    
    init(_ title: String) {
        self.title = title
    }
    
    func leadingAction(systemImageName image: String, _ action: @autoclosure @escaping EmptyCallback) -> NavigationBar {
        var newNavigationBar = self
        
        newNavigationBar.leadingButtonSystemImageName = image
        newNavigationBar.leadingButtonCallback = action
        
        return newNavigationBar
    }
    
    func leadingAction(imageName image: String, _ action: @autoclosure @escaping EmptyCallback) -> NavigationBar {
        var newNavigationBar = self
        
        newNavigationBar.leadingButtonImageName = image
        newNavigationBar.leadingButtonCallback = action
        
        return newNavigationBar
    }
    
    func secondLeadingAction(systemImageName image: String, _ action: @autoclosure @escaping EmptyCallback) -> NavigationBar {
        var newNavigationBar = self
        
        newNavigationBar.secondLeadingButtonSystemImageName = image
        newNavigationBar.secondLeadingButtonCallback = action
        
        return newNavigationBar
    }
    
    func secondLeadingAction(imageName image: String, _ action: @autoclosure @escaping EmptyCallback) -> NavigationBar {
        var newNavigationBar = self
        
        newNavigationBar.secondLeadingButtonImageName = image
        newNavigationBar.secondLeadingButtonCallback = action
        
        return newNavigationBar
    }
    
    func trailingAction(systemImageName image: String, _ action: @autoclosure @escaping EmptyCallback) -> NavigationBar {
        var newNavigationBar = self
        
        newNavigationBar.trailingButtonSystemImageName = image
        newNavigationBar.trailingButtonCallback = action
        
        return newNavigationBar
    }
    
    func trailingAction(imageName image: String, _ action: @autoclosure @escaping EmptyCallback) -> NavigationBar {
        var newNavigationBar = self
        
        newNavigationBar.trailingButtonImageName = image
        newNavigationBar.trailingButtonCallback = action
        
        return newNavigationBar
    }
    
    func secondTrailingAction(sytemImageName image: String, _ action: @autoclosure @escaping EmptyCallback) -> NavigationBar {
        var newNavigationBar = self
        
        newNavigationBar.secondTrailingButtonSystemImageName = image
        newNavigationBar.secondTrailingButtonCallback = action
        
        return newNavigationBar
    }
    
    func secondTrailingAction(imageName image: String, _ action: @autoclosure @escaping EmptyCallback) -> NavigationBar {
        var newNavigationBar = self
        
        newNavigationBar.secondTrailingButtonImageName = image
        newNavigationBar.secondTrailingButtonCallback = action
        
        return newNavigationBar
    }
    
    var body: some View {
        HStack(spacing: 12) {
            generateButton(leadingButtonImageName, systemImageName: leadingButtonSystemImageName, action: leadingButtonCallback)
            
            generateButton(secondLeadingButtonImageName, systemImageName: secondLeadingButtonSystemImageName, action: secondLeadingButtonCallback)
            
            Text(title)
                .foregroundColor(.black)
                .font(.headline)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity)
            
            generateButton(secondTrailingButtonImageName, systemImageName: secondTrailingButtonSystemImageName, action: secondTrailingButtonCallback)
            
            generateButton(trailingButtonImageName, systemImageName: trailingButtonSystemImageName, action: trailingButtonCallback)
        }
        .padding(.horizontal, 8)
        .padding(.bottom, Self.bottomPadding)
        .padding(.top, Self.topPadding)
        .background(.white)
        .addShadow()
    }
    
    @ViewBuilder
    func generateButton(_ imageName: String?, systemImageName: String?, action: EmptyCallback?) -> some View {
        if let imageName {
            Image(imageName)
                .resizable()
                .renderingMode(.template)
                .scaledToFit()
                .foregroundColor(.blue)
                .frame(width: Self.imageSize, height: Self.imageSize)
                .frame(width: Self.imageTapSize, height: Self.imageTapSize)
                .contentShape(Rectangle())
                .onTapGesture {
                    action?()
                }
        } else if let systemImageName {
            Image(systemName: systemImageName)
                .resizable()
                .scaledToFit()
                .foregroundColor(.blue)
                .frame(width: Self.imageSize, height: Self.imageSize)
                .frame(width: Self.imageTapSize, height: Self.imageTapSize)
                .contentShape(Rectangle())
                .onTapGesture {
                    action?()
                }
        } else {
            Color.clear
                .frame(width: Self.imageTapSize, height: Self.imageTapSize)
        }
    }
    
    static let imageSize: CGFloat = 20
    static let imageTapSize: CGFloat = 40
    static let topPadding: CGFloat = max(8, UIScreen.unsafeTopPadding)
    static let bottomPadding: CGFloat = 8
    
    static let totalHeight: CGFloat = Self.topPadding + Self.imageTapSize + Self.bottomPadding
}

struct NavigationBar_Previews: PreviewProvider {
    
    static var previews: some View {
        NavigationBar("Sample Title")
            .leadingAction(systemImageName: "plus", ())
            .trailingAction(systemImageName: "minus", ())
            .shadow(radius: 16)
    }
}
