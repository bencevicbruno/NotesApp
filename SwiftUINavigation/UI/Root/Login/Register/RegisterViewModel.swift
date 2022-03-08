//
//  RegisterViewModel.swift
//  SwiftUINavigation
//
//  Created by Bruno Benčević on 02.03.2022..
//

import Foundation
import FirebaseAuth

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
        isLoading = true
        
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let self = self else { return }
            
            Auth.auth().createUser(withEmail: self.email, password: self.password) { [weak self] result, error in
                guard let self = self else { return }
                self.isLoading = false
                
                if let result = result {
                    self.handleAuthSuccess(result)
                } else if let error = error {
                    self.handleAuthFailure(error)
                } else {
                    self.dialog = Dialog(title: "Unknown error", message: "This shouldn't even happen.")
                }
            }
        }
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
//            guard let self = self else { return }
//
//            let user = LocalUser(name: name, lastName: lastName, email: email)
//            persistenceService.localUser = user
//
//
//
//            isLoading = false
//            self.onRegistered?()
//        }
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
    
    func handleAuthSuccess(_ result: AuthDataResult) {
        print("great success: \(result)")
    }
    
    func handleAuthFailure(_ error: Error) {
        self.dialog = Dialog(title: "Error", message: error.localizedDescription)
        print(error)
    }
}
