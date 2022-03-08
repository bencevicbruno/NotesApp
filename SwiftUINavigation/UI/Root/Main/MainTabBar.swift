//
//  MainTabBar.swift
//  SwiftUINavigation
//
//  Created by Bruno Benčević on 05.03.2022..
//

import SwiftUI

struct MainTabBar: View {
    
    @Binding var currentTab: MainTab
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(MainTab.allCases) { tab in
                VStack(spacing: 5) {
                    Image(systemName: tab == currentTab ? tab.systemImageSelected : tab.systemImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 25, height: 25)
                    
                    Text(tab.title)
                        .font(.captionSmall)
                }
                .foregroundColor(tab == currentTab ? .blue : .black)
                .frame(maxWidth: .infinity)
                .contentShape(Rectangle())
                .onTapGesture {
                    currentTab = tab
                }
            }
        }
        .frame(height: Self.height)
        .padding(.top, 10)
        .background(RoundedRectangle.rounded(.white, top: 10))
        .clipped()
        .shadow(color: .gray, radius: 5, x: 0, y: -5)
        .mask(Rectangle().padding(.top, -20))
    }
    
    static let height: CGFloat = 45
}

struct MainTabBar_Previews: PreviewProvider {
    static var previews: some View {
        MainTabBar(currentTab: .constant(.notes))
    }
}
