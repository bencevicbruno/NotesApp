//
//  LoginViewModel.swift
//  SwiftUINavigation
//
//  Created by Bruno Benčević on 28.02.2022..
//

import SwiftUI

final class LoginViewModel: ObservableObject {
    
    @Published var username = ""
    @Published var password = ""
    @Published var keepLoggedIn = false
    
    @Binding private var rootFlow: RootFlow
    
    var persistenceService: PersistenceServiceProtocol = ServiceFactory.persistenceService
    
    init(rootFlow: Binding<RootFlow>) {
        self._rootFlow = rootFlow
    }
    
    func loginTapped() {
        let user = LocalUser(name: "Dunno, logged in with email", lastName: "dunno", email: username)
        persistenceService.localUser = user
        self.rootFlow = .main
    }
}
