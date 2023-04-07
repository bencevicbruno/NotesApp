//
//  LoginView.swift
//  SwiftUINavigation
//
//  Created by Bruno Benčević on 28.02.2022..
//

import SwiftUI

enum LoginField {
    case username
    case password
}

extension DispatchQueue {
    
    func delay(_ delay: Double = 0.2, _ action: @escaping () -> Void) {
        asyncAfter(deadline: .now() + delay) {
            action()
        }
    }
}

struct LoginView: View {
    
    @ObservedObject var viewModel: LoginViewModel
    
    @State private var focusedField: LoginField?
    
    var body: some View {
        VStack {
            Spacer()
            
            notesAppTitle
            
            Spacer()
            
            VStack {
                CustomTextField(title: "Username", text: $viewModel.username, isFocused: focusBinding(for: .username), onCommit: { focusedField = .password
                })
                .onTapGesture { }
                .padding(.bottom)
                
                CustomTextField(title: "Password", text: $viewModel.password, isFocused: focusBinding(for: .password), onCommit: {
                    focusedField = nil
                    DispatchQueue.main.delay {
                        viewModel.loginTapped()
                    }
                })
                .onTapGesture { }
            }
            
            Spacer()
            
            loginButton
                .padding(.bottom)
                .padding(.bottom)
            
        }
        .padding(.horizontal, 20)
        .navigationTitle("Login")
        .contentShape(Rectangle())
        .onTapGesture {
            withAnimation {
                focusedField = nil
            }
        }
    }
}

private extension LoginView {
    
    var notesAppTitle: some View {
        VStack {
            Image(systemName: "list.bullet.clipboard")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: UIScreen.width / 2)
            
            HStack(alignment: .lastTextBaseline) {
                Text("NOTES")
                    .font(.system(size: 56, weight: .bold))
                
                +
                
                Text("APP")
                    .font(.system(size: 40, weight: .medium))
            }
        }
    }
    
    func focusBinding(for field: LoginField) -> Binding<Bool> {
        return .init(get: {
            focusedField == field
        }, set: { focused in
            if focused {
                focusedField = field
            }
        })
    }
    
    var loginButton: some View {
        Button(action: viewModel.loginTapped) {
            Text("LOGIN")
                .font(.title)
                .fontWeight(.bold)
                .frame(height: 60)
                .frame(maxWidth: .infinity)
                .background(LinearGradient(colors: [.blue, .black.opacity(0.1)], startPoint: .top, endPoint: .bottom))
                .background(.blue)
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 16))
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(viewModel: .init(rootFlow: .constant(.login)))
    }
}
