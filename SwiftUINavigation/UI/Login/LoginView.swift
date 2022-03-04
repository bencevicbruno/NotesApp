//
//  LoginView.swift
//  SwiftUINavigation
//
//  Created by Bruno Benčević on 28.02.2022..
//

import SwiftUI

struct LoginView: View {
    
    @ObservedObject var viewModel: LoginViewModel
    
    var body: some View {
        Form {
            HStack {
                Spacer()
                
                Text("LOG IN")
                    .fontWeight(.bold)
                    .font(.system(size: 24))
                
                Spacer()
            }
            
            HStack {
                Text("Email:")
                
                TextField("Email", text: $viewModel.email)
            }
            
            HStack {
                Text("Password: ")
                
                SecureField("Password", text: $viewModel.password)
            }
            
            Toggle("Keep me logged in (not implemented)", isOn: $viewModel.keepLoggedIn)
            
            Spacer(minLength: 100)
            
            HStack {
                Spacer()
                
                Button("Register") {
                    viewModel.registerTapped()
                    print("reg")
                }
                .buttonStyle(.bordered)
                
                Spacer()
                
                Text("or")
                
                Spacer()
                
                Button("Log In") {
                    viewModel.loginTapped()
                    print("log")
                }
                .buttonStyle(.borderedProminent)
                
                Spacer()
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(viewModel: LoginViewModel(persistenceService: ServiceFactory.persistenceService))
    }
}
