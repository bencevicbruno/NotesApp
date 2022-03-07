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
    @Published var dialog: Dialog?
    @Published var isLoading = false
    
    var onDismissed: EmptyCallback?
    var onRegistered: EmptyCallback?
    
    private var persistenceService: PersistenceServiceProtocol
    
    init(persistenceService: PersistenceServiceProtocol) {
        self.persistenceService = persistenceService
    }
    
    func registerTapped() {
        guard areInputFieldsValid() else { return }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [self] in
            let user = LocalUser(name: name, lastName: lastName, email: email)
            persistenceService.localUser = user
            self.onRegistered?()
        }
    }
    
    func dismiss() {
        self.onDismissed?()
    }
}

private extension RegisterViewModel {
    
    func areInputFieldsValid() -> Bool {
        guard name != "" else {
            dialog = Dialog(title: "Invalid input", message: "Name can not be empty.")
            return false
        }
        
        guard lastName != "" else {
            dialog = Dialog(title: "Invalid input", message: "Last name can not be empty.")
            return false
        }
        
        guard email != "" else {
            dialog = Dialog(title: "Invalid input", message: "Email can not be empty.")
            return false
        }
        
        guard password != "" else {
            dialog = Dialog(title: "Invalid input", message: "Password can not be empty.")
            return false
        }
        
        return true
    }
}
