//
//  MainTabBar.swift
//  SwiftUINavigation
//
//  Created by Bruno Bencevic on 07.03.2023..
//

import SwiftUI

struct MainTabBar: View {
    
    @Binding var currentTab: MainTab
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(MainTab.allCases) { tab in
                VStack(spacing: 4) {
                    Image(systemName: tab.systemImageName(isSelected: tab == currentTab))
                        .resizable()
                        .scaledToFit()
                        .frame(width: Self.imageSize, height: Self.imageSize)
                }
                .foregroundColor(tab == currentTab ? .blue : .black)
                .fontWeight(tab == currentTab ?
                    .semibold : .regular)
                .frame(height: Self.imageTapSize)
                .contentShape(Rectangle())
                .onTapGesture {
                    currentTab = tab
                }
                .frame(maxWidth: .infinity)
                .padding(.top, Self.topPadding)
                .padding(.bottom, Self.bottomPadding)
            }
        }
        .background(.white)
        .mask {
            tabBarMask
        }
    }
    
    static let imageSize: CGFloat = 28
    static let imageTapSize: CGFloat = 40
    static let topPadding: CGFloat = 16
    static let bottomPadding: CGFloat = max(16, UIScreen.unsafeBottomPadding)
    
    static let totalHeight: CGFloat = Self.topPadding + Self.imageTapSize + Self.bottomPadding
}

private extension MainTabBar {
    
    var tabBarMask: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
            
            Rectangle()
                .padding(.top, 16)
        }
    }
}

struct MainTabBar_Previews: PreviewProvider {
    
    static var previews: some View {
        MainTabBar(currentTab: .constant(.notes))
            .shadow(radius: 16)
    }
}
