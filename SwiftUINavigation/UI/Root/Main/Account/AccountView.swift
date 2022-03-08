//
//  AccountView.swift
//  SwiftUINavigation
//
//  Created by Bruno Benčević on 25.02.2022..
//

import SwiftUI

struct AccountView: View {
    
    @ObservedObject var viewModel: AccountViewModel
    
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
        .confirmationDialog($viewModel.confirmationDialog)
    }
}

private extension AccountView {
    
    var background: some View {
        Image("background_account")
            .resizable()
    }
    
    var navigationBar: some View {
        HStack(spacing: 0) {
            Rectangle()
                .fill(.white)
                .frame(width: 20, height: 20)
            
            Spacer(minLength: 10)
            
            Text("Account")
                .font(.system(size: 24))
                .fontWeight(.bold)
            
            Spacer(minLength: 10)
            
            Image(systemName: "arrowshape.turn.up.backward")
                .resizable()
                .scaledToFit()
                .font(.system(size: 20, weight: .medium))
                .frame(width: 20, height: 20)
                .foregroundColor(.blue)
                .contentShape(Rectangle())
                .onTapGesture {
                    viewModel.showLogOutDialog()
                }
        }
        .padding(.horizontal, 10)
        .frame(height: 50)
        .background(RoundedRectangle.rounded(.white, top: 0, bottom: 10))
    }
    
    var content: some View {
        EmptyView()
//        VStack {
//            Text("Hello, \(viewModel.name)")
//            
//            Group {
//                Text("TODO: Deep-link with notification")
//                    .fontWeight(.bold)
//                
//                Text("ie. Reminder to read the Bible")
//            }
//            .multilineTextAlignment(.leading)
//        }
//        .frame(maxWidth: .infinity, minHeight: 100)
//        .padding(.vertical, 10)
//        .padding(.horizontal, 20)
//        .background(RoundedRectangle(cornerRadius: 10)
//                        .fill(.thinMaterial))
//        .padding(.vertical, 10)
//        .padding(.horizontal, 20)
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView(viewModel: AccountViewModel(persistenceService: ServiceFactory.persistenceService))
    }
}
