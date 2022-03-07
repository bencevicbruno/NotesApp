//
//  AccountViewModel.swift
//  SwiftUINavigation
//
//  Created by Bruno Benčević on 25.02.2022..
//

import Foundation
import SwiftUI

final class AccountViewModel: ObservableObject {
    
    @Published var name = "unknown"
    @Published var lastName = "unkown"
    @Published var email = "unknown"
    @Published var confirmationDialog: ConfirmationDialog?
    
    var persistenceService: PersistenceServiceProtocol
    
    var onLoggedOut: EmptyCallback?
    
    init(persistenceService: PersistenceServiceProtocol) {
        self.persistenceService = persistenceService
        
        name = persistenceService.localUser?.name ?? "unkown"
        lastName = persistenceService.localUser?.lastName ?? "unknown"
        email = persistenceService.localUser?.email ?? "unkown"
    }
    
    func showLogOutDialog() {
        self.confirmationDialog = ConfirmationDialog(title: "Log out?",
                                                     message: "You can always log back in.",
                                                     confirmationTitle: "Log out",
                                                     confirmAction: { [weak self] in self?.logOut() })
    }
}

private extension AccountViewModel {
    
    func logOut() {
        persistenceService.localUser = nil
        self.onLoggedOut?()
    }
}
