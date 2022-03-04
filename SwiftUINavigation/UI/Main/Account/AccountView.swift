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
            }
            .edgesIgnoringSafeArea(.top)
        }
        .confirmationDialog($viewModel.confirmationDialog)
    }
}

private extension AccountView {
    
    var background: some View {
        Image("background_account")
            .resizable()
            .ignoresSafeArea(.all, edges: .top)
    }
    
    var navigationBar: some View {
        VStack(spacing: 0) {
            Rectangle()
                .fill(.white)
                .frame(height: UIScreen.main.topSafeAreaPadding)
            
            ZStack(alignment: .center) {
                RoundedRectangle.rounded(.white, top: 0, bottom: 10)
                
                Text("Account")
                    .font(.system(size: 24))
                    .fontWeight(.bold)
            }
            .frame(height: 50)
        }
    }
    
    var content: some View {
        VStack {
            Text("Hello, \(viewModel.name)")
            
            Button("Log Out") {
                viewModel.showLogOutDialog()
            }
            .buttonStyle(.bordered)
            
            Group {
                Text("TODO: Deep-link with notification")
                    .fontWeight(.bold)
                
                Text("ie. Reminder to read the Bible")
            }
            .multilineTextAlignment(.leading)
        }
        .frame(maxWidth: .infinity, minHeight: 100)
        .padding(.vertical, 10)
        .padding(.horizontal, 20)
        .background(RoundedRectangle(cornerRadius: 10)
                        .fill(.thinMaterial))
        .padding(.vertical, 10)
        .padding(.horizontal, 20)
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView(viewModel: AccountViewModel(persistenceService: ServiceFactory.persistenceService))
    }
}
