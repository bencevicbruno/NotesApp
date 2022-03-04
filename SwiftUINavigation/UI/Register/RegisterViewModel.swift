//
//  RegisterViewModel.swift
//  SwiftUINavigation
//
//  Created by Bruno Benčević on 02.03.2022..
//

import Foundation

final class RegisterViewModel: ObservableObject {
    
    @Published var name = ""
    @Published var lastName = ""
    @Published var email = ""
    @Published var password = ""
    @Published var isShowingAlert = false
    @Published var alertError: String?
    
    var onDismissed: EmptyCallback?
    var onRegistered: EmptyCallback?
    
    private var persistenceService: PersistenceServiceProtocol
    
    init(persistenceService: PersistenceServiceProtocol) {
        self.persistenceService = persistenceService
    }
    
    func register() {
        guard name != "" else { return showError("Name cant be empty") }
        guard lastName != "" else { return showError("Last name cant be empty") }
        guard email != "" else { return showError("Eamil cant be empty") }
        guard password != "" else { return showError("Password cant be empty") }
        
        let user = LocalUser(name: name, lastName: lastName, email: email)
        persistenceService.localUser = user
        self.onRegistered?()
    }
    
    func dismiss() {
        self.onDismissed?()
    }
}

private extension RegisterViewModel {
    
    func showError(_ message: String) {
        alertError = message
        isShowingAlert = true
    }
}
