//
//  LoginViewModel.swift
//  SwiftUINavigation
//
//  Created by Bruno Benčević on 28.02.2022..
//

import Foundation

final class LoginViewModel: ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    @Published var keepLoggedIn = false
    @Published var isLoading = false
    @Published var dialog: Dialog?
    
    var persistenceService: PersistenceServiceProtocol
    
    var onGoToMain: EmptyCallback?
    var onGoToRegister: EmptyCallback?
    
    init(persistenceService: PersistenceServiceProtocol) {
        self.persistenceService = persistenceService
    }
    
    func loginTapped() {
        guard !email.isEmpty else {
            dialog = Dialog(title: "Email can not be empty.", message: "Please input your email to login.")
            return
        }
        
        guard !password.isEmpty else {
            dialog = Dialog(title: "Password can not be empty.", message: "Please input your password to login.")
            return
        }
        
        self.isLoading = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [self] in
            let user = LocalUser(name: "Dunno, logged in with email", lastName: "dunno", email: email)
            persistenceService.localUser = user
            self.onGoToMain?()
        }
    }
    
    func registerTapped() {
        self.onGoToRegister?()
    }
}
