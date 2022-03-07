//
//  RegisterView.swift
//  SwiftUINavigation
//
//  Created by Bruno Benčević on 02.03.2022..
//

import SwiftUI

struct RegisterView: View {
    
    @ObservedObject var viewModel: RegisterViewModel
    
    private let headerSize: CGFloat = 40
    
    var body: some View {
        ZStack(alignment: .top) {
            ScrollView(.vertical) {
                content
                    .padding(.top, headerSize + 15)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 10)
            }
            
            header
                .shadow(color: .gray, radius: 5, x: 0, y: 5)
                .mask(Rectangle().padding(.bottom, -20))
        }
        .dialog($viewModel.dialog)
        .loadingOverlay(isLoading: viewModel.isLoading)
    }
    
    var header: some View {
        HStack(spacing: 0) {
            Rectangle()
                .fill(.clear)
                .frame(width: 30, height: 30)
            
            Spacer(minLength: 10)
            
            Text("Register")
                .font(.display)
                .fontWeight(.bold)
                .textCase(.uppercase)
            
            Spacer(minLength: 10)
            
            Image(systemName: "x.circle")
                .resizable()
                .scaledToFit()
                .foregroundColor(.blue)
                .frame(width: 25, height: 25)
                .frame(width: 30, height: 30)
                .contentShape(Rectangle())
                .onTapGesture {
                    viewModel.dismiss()
                }
        }
        .padding(.horizontal, 10)
        .frame(maxWidth: .infinity)
        .frame(height: headerSize)
        .background(RoundedRectangle.rounded(.white, top: 0, bottom: 15))
        .clipped()
    }
    
    var content: some View {
        LazyVStack(alignment: .leading) {
            TextSeparator("General", font: .header2)
                .foregroundColor(.gray)
            
            generalForm
                .padding(.bottom, 40)
            
            TextSeparator("Info", font: .header2)
                .foregroundColor(.gray)
            
            infoForm
                .padding(.bottom, 40)
            
            registerButton
        }
        .padding(20)
        .background(RoundedRectangle(cornerRadius: 10)
                        .fill(Color.body))
    }
    
    var generalForm: some View {
        LazyVStack(alignment: .leading) {
            Text("Email")
                .font(.header2)
                .fontWeight(.semibold)
                .frame(height: 30)
            
            TextField("", text: $viewModel.email)
                .padding(5)
                .frame(height: 30)
                .background(RoundedRectangle(cornerRadius: 5)
                                .fill(Color.body))
            
            Text("Password")
                .font(.header2)
                .fontWeight(.semibold)
                .frame(height: 30)
            
            TextField("", text: $viewModel.password).padding(5)
                .frame(height: 30)
                .background(RoundedRectangle(cornerRadius: 5)
                                .fill(Color.body))
        }
    }
    
    var infoForm: some View {
        LazyVStack(alignment: .leading) {
            Text("First name").font(.header2)
                .fontWeight(.semibold)
                .frame(height: 30)
            
            TextField("", text: $viewModel.name).padding(5)
                .frame(height: 30)
                .background(RoundedRectangle(cornerRadius: 5)
                                .fill(Color.body))
            
            Text("Last name").font(.header2)
                .fontWeight(.semibold)
                .frame(height: 30)
            
            TextField("", text: $viewModel.lastName).padding(5)
                .frame(height: 30)
                .background(RoundedRectangle(cornerRadius: 5)
                                .fill(Color.body))
        }
    }
    
    var registerButton: some View {
        HStack {
            Spacer()
            
            Button {
                viewModel.registerTapped()
            } label: {
                Text("Register")
                    .fontWeight(.bold)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 50)
                    .background(RoundedRectangle(cornerRadius: 5)
                                    .fill(Color.body))
            }
            
            Spacer()
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView(viewModel: RegisterViewModel(persistenceService: ServiceFactory.persistenceService))
    }
}
