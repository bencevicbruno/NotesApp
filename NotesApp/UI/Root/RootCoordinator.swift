//
//  RootCoordinator.swift
//  SwiftUINavigation
//
//  Created by Bruno Benčević on 28.02.2022..
//

import Combine
import SwiftUI

enum RootFlow {
    case login
    case main
}

final class RootCoordinator: ObservableObject {
    
    @Published var flow: RootFlow
    
    var loginCoordinator: LoginCoordinator!
    var mainCoordinator: MainCoordinator!
    
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        if ServiceFactory.persistenceService.localUser != nil {
            flow = .main
        } else {
            flow = .login
        }
        
        self._flow.projectedValue
            .sink { [weak self] newFlow in
                switch newFlow {
                case .login:
                    self?.goToLogin()
                case .main:
                    self?.goToMain()
                }
            }
            .store(in: &cancellables)
    }
    
    func goToMain() {
        self.mainCoordinator = MainCoordinator()
        self.loginCoordinator = nil
        
        mainCoordinator.onLoggedOut = { [weak self] in
            self?.flow = .login
        }
    }
    
    func goToLogin() {
        self.loginCoordinator = LoginCoordinator(rootFlow: .init(get: { self.flow }, set: { self.flow = $0 }))
        self.mainCoordinator = nil
    }
}

struct RootCoordinatorView: View {
    
    @ObservedObject var coordinator: RootCoordinator
    
    var body: some View {
        switch coordinator.flow {
        case .login:
            LoginCoordinatorView(coordinator: coordinator.loginCoordinator)
        case .main:
            MainCoordinatorView(coordinator: coordinator.mainCoordinator)
        }
    }
}
