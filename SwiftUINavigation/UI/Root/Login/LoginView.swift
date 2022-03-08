//
//  LoginView.swift
//  SwiftUINavigation
//
//  Created by Bruno Benčević on 28.02.2022..
//

import SwiftUI

struct LoginView: View {
    
    @ObservedObject var viewModel: LoginViewModel
    
    @FocusState private var focusedField: Field?
    
    private let headerSize: CGFloat = 40
    
    var body: some View {
        ZStack(alignment: .top) {
            content
                .padding(.top, headerSize + 15)
                .padding(.horizontal, 20)
                .padding(.bottom, 10)
            
            header
                .shadow(color: .gray, radius: 5, x: 0, y: 5)
                .mask(Rectangle().padding(.bottom, -20))
        }
        .dialog($viewModel.dialog)
        .loadingOverlay(isLoading: viewModel.isLoading)
    }
}

private extension LoginView {
    
    var header: some View {
        Text("Log in")
            .font(.display)
            .fontWeight(.bold)
            .textCase(.uppercase)
            .frame(maxWidth: .infinity)
            .frame(height: headerSize)
            .background(RoundedRectangle.rounded(.white, top: 0, bottom: 15))
            .clipped()
    }
    
    var content: some View {
        VStack(spacing: 15) {
            loginForm
            
            TextSeparator("OR", font: .header2)
                .padding(.vertical, 10)
            
            registerButton
            
            Spacer()
        }
    }
    
    var loginForm: some View {
        VStack {
            VStack(alignment: .leading, spacing: 0) {
                Text("Email:")
                    .font(.header2)
                    .fontWeight(.semibold)
                    .frame(height: 30)
                
                TextField("", text: $viewModel.email)
                    .focused($focusedField, equals: .email)
                    .padding(5)
                    .frame(height: 30)
                    .background(RoundedRectangle(cornerRadius: 5)
                                    .fill(Color.body))
                    .padding(.bottom, 10)
                
                Text("Password:")
                    .font(.header2)
                    .fontWeight(.semibold)
                    .frame(height: 30)
                
                SecureField("", text: $viewModel.password)
                    .focused($focusedField, equals: .password)
                    .padding(5)
                    .frame(height: 30)
                    .background(RoundedRectangle(cornerRadius: 5)
                                    .fill(Color.body))
            }
            
            HStack {
                Text("Stay logged in:")
                    .fontWeight(.semibold)
                    .font(.header3)
                
                Spacer()
                
                Toggle("", isOn: $viewModel.keepLoggedIn)
                    .labelsHidden()
            }
            .frame(height: 30)
            .padding(.top, 30)
            
            loginButton
                .padding(.top, 10)
        }
        .padding(20)
        .background(RoundedRectangle(cornerRadius: 10)
                        .fill(Color.body))
    }
    
    var loginButton: some View {
        Button {
            viewModel.loginTapped()
        } label: {
            Text("Log in")
                .fontWeight(.bold)
                .padding(.vertical, 10)
                .padding(.horizontal, 50)
                .background(RoundedRectangle(cornerRadius: 5)
                                .fill(Color.body)
                                .shadow(color: .gray, radius: 5, x: 0, y: 5))
        }
    }
    
    var registerButton: some View {
        Button {
            viewModel.registerTapped()
        } label: {
            Text("Register")
                .fontWeight(.bold)
                .padding(.vertical, 10)
                .padding(.horizontal, 50)
                .background(RoundedRectangle(cornerRadius: 5)
                                .fill(Color.body)
                                .shadow(color: .gray, radius: 5, x: 0, y: 5))
        }
    }
    
    private enum Field: Hashable {
        case email, password
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(viewModel: LoginViewModel(persistenceService: ServiceFactory.persistenceService))
    }
}
