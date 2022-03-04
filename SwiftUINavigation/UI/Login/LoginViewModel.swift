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
    
    var persistenceService: PersistenceServiceProtocol
    
    var onGoToMain: EmptyCallback?
    var onGoToRegister: EmptyCallback?
    
    init(persistenceService: PersistenceServiceProtocol) {
        self.persistenceService = persistenceService
    }
    
    func loginTapped() {
        let user = LocalUser(name: "Dunno, logged in with email", lastName: "dunno", email: email)
        persistenceService.localUser = user
        print("\(persistenceService.localUser) from loginTapped")
        self.onGoToMain?()
    }
    
    func registerTapped() {
        self.onGoToRegister?()
    }
}
