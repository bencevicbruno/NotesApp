//
//  GroupsView.swift
//  SwiftUINavigation
//
//  Created by Bruno Benčević on 25.02.2022..
//

import SwiftUI

struct GroupsView: View {
    
    @ObservedObject var viewModel: GruopsViewModel
    
    var body: some View {
        ZStack(alignment: .top) {
            background
            
            VStack(spacing: 0) {
                navigationBar
                
                content
                    .padding(.bottom, MainTabBar.height)
            }
        }
        .removeNavigationBar()
    }
}

private extension GroupsView {
    
    var background: some View {
        Image("background_groups")
            .resizable()
    }
    
    var navigationBar: some View {
        Text("Groups")
            .font(.system(size: 24))
            .fontWeight(.bold)
            .padding(.horizontal, 10)
            .frame(maxWidth: .infinity, minHeight: 50, maxHeight: 50)
            .background(RoundedRectangle.rounded(.white, top: 0, bottom: 10))
    }
    
    var content: some View {
        VStack {
            Spacer()
            
            Text("Groups functionality coming up right when I get to learn some Firebase stuff.")
                .multilineTextAlignment(.center)
                .padding(20)
                .background(RoundedRectangle(cornerRadius: 10)
                                .fill(.ultraThinMaterial))
                .frame(maxWidth: 200)
            
            Spacer()
        }
    }
}

struct GroupsView_Previews: PreviewProvider {
    static var previews: some View {
        GroupsView(viewModel: GruopsViewModel(coordinator: nil))
    }
}
