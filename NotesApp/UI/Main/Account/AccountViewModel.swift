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
    
    @ObservedObject var mainViewModel = MainViewModel.instance
    
    var persistenceService: PersistenceServiceProtocol
    
    var onLoggedOut: EmptyCallback?
    
    init(persistenceService: PersistenceServiceProtocol) {
        self.persistenceService = persistenceService
        
        name = persistenceService.localUser?.name ?? "unkown"
        lastName = persistenceService.localUser?.lastName ?? "unknown"
        email = persistenceService.localUser?.email ?? "unkown"
    }
    
    func showLogOutDialog() {
        mainViewModel.confirmationDialog = ConfirmationDialog(title: "Log out?",
                                                     message: "You can always sign back in.",
                                                     confirmationTitle: "Sign out",
                                                     confirmAction: { [weak self] in self?.logOut() })
    }
    
    func logOut() {
        persistenceService.localUser = nil
        self.onLoggedOut?()
    }
}
