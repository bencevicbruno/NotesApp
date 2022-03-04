//
//  RootCoordinator.swift
//  SwiftUINavigation
//
//  Created by Bruno Benčević on 28.02.2022..
//

import Foundation
import SwiftUI

final class RootCoordinator: ObservableObject {
    
    @Published var loginCoordinator: LoginCoordinator!
    @Published var mainCoordinator: MainCoordinator!
    
    init() {
        if ServiceFactory.persistenceService.localUser != nil {
            goToMain()
        } else {
            goToLogin()
        }
    }
    
    func goToMain() {
        self.mainCoordinator = MainCoordinator()
        self.loginCoordinator = nil
        
        mainCoordinator.onLoggedOut = { [weak self] in
            self?.goToLogin()
        }
    }
    
    func goToLogin() {
        self.loginCoordinator = LoginCoordinator()
        self.mainCoordinator = nil
        
        loginCoordinator.onGoToMain = { [weak self] in
            self?.goToMain()
        }
    }
}

struct RootCoordinatorView: View {
    
    @ObservedObject var coordinator: RootCoordinator
    
    var body: some View {
        if let loginCoordinator = coordinator.loginCoordinator {
            LoginCoordinatorView(coordinator: loginCoordinator)
        } else if let mainCoordinator = coordinator.mainCoordinator {
            MainCoordinatorView(coordinator: mainCoordinator)
        } else {
            Text("RootCoordinatorError - maybe loading?")
        }
    }
}
