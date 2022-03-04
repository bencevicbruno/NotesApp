//
//  RegisterView.swift
//  SwiftUINavigation
//
//  Created by Bruno Benčević on 02.03.2022..
//

import SwiftUI

struct RegisterView: View {
    
    @ObservedObject var viewModel: RegisterViewModel
    
    var body: some View {
        Form {
            HStack {
                Spacer()
                
                Text("REGISTER")
                    .fontWeight(.bold)
                    .font(.system(size: 24))
                
                Spacer()
            }
            
            Section {
                TextField("Email", text: $viewModel.email)
                
                TextField("Password", text: $viewModel.password)
            } header: {
                Text("General")
            }
            
            Section {
                TextField("Name", text: $viewModel.name)
                
                TextField("Last name", text: $viewModel.lastName)
            } header: {
                Text("Personal Information")
            }
            
            HStack {
                Button("Dismiss") {
                    viewModel.dismiss()
                }
                .buttonStyle(.bordered)
                
                Spacer()
                
                Button("Register") {
                    viewModel.register()
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .alert("", isPresented: $viewModel.isShowingAlert, presenting: viewModel.alertError) { error in
            Button("OK", role: .cancel, action: {})
        } message: { error in
            Text(error)
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView(viewModel: RegisterViewModel(persistenceService: ServiceFactory.persistenceService))
    }
}
