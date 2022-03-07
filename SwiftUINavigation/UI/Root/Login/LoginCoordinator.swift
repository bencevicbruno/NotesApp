//
//  LoginCoordinator.swift
//  SwiftUINavigation
//
//  Created by Bruno Benčević on 28.02.2022..
//

import Foundation
import SwiftUI

final class LoginCoordinator: ObservableObject {
    
    @Published var viewModel = LoginViewModel(persistenceService: ServiceFactory.persistenceService)
    @Published var registerViewModel: RegisterViewModel?
    
    var onGoToMain: EmptyCallback?
    
    init() {
        viewModel.onGoToMain = { [weak self] in
            self?.onGoToMain?()
        }
        
        viewModel.onGoToRegister = { [weak self] in
            self?.goToRegister()
        }
    }
    
    func goToRegister() {
        self.registerViewModel = RegisterViewModel(persistenceService: ServiceFactory.persistenceService)
        
        registerViewModel?.onDismissed = { [weak self] in
            self?.registerViewModel = nil
        }
        
        registerViewModel?.onRegistered = { [weak self] in
            self?.registerViewModel = nil
            self?.onGoToMain?()
        }
    }
}

struct LoginCoordinatorView: View {
    
    @ObservedObject var coordinator: LoginCoordinator
    
    var body: some View {
        LoginView(viewModel: coordinator.viewModel)
            .presentNavigation(item: $coordinator.registerViewModel) { viewModel in
                RegisterView(viewModel: viewModel)
            }
    }
}
