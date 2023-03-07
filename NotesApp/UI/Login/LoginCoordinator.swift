//
//  LoginCoordinator.swift
//  SwiftUINavigation
//
//  Created by Bruno Benčević on 28.02.2022..
//

import Foundation
import SwiftUI

final class LoginCoordinator: ObservableObject {
    
    @Published var viewModel: LoginViewModel
    
    init(rootFlow: Binding<RootFlow>) {
        self.viewModel = LoginViewModel(rootFlow: rootFlow)
    }
}

struct LoginCoordinatorView: View {
    
    @ObservedObject var coordinator: LoginCoordinator
    
    var body: some View {
        LoginView(viewModel: coordinator.viewModel)
    }
}
